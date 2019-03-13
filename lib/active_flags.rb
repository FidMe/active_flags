require "active_flags/engine"
require_relative 'active_flags/handler/flag_mapper'
require_relative 'active_flags/handler/flag_builder'
require_relative 'utils/value_stringifier'

module ActiveFlags
  extend ActiveSupport::Concern

  class_methods do
    def has_flags(*authorized_flags)
      has_many :flags_as_collection, class_name: 'ActiveFlags::Flag', as: :subject

      define_method(:flags=) do |flags|
        Handler::FlagMapper.remap(authorized_flags, flags.symbolize_keys).each do |flag_attributes|
          Handler::FlagBuilder.new(self, flag_attributes).save
        end
      end

      define_method(:flags) do
        hash_of_flags = {}
        flags_as_collection.each do |flag|
          hash_of_flags[flag.key.to_sym] = flag.value
        end
        hash_of_flags.with_indifferent_access
      end
    end

    def method_missing(method_name, *args)
      super(method_name, *args) unless method_name.to_s.include?(prefix = 'flagged_as_')
      different_from = method_name.to_s.starts_with?('not')
      flag = method_name.to_s.gsub(different_from ? "not_#{prefix}" : prefix, '')
      condition = { active_flags_flags: { value: stringify(args[0]) } }

      joins(:flags_as_collection)
        .where(active_flags_flags: { key: flag })
        .send(different_from ? 'where' : 'all')
        .send(different_from ? 'not' : 'where', condition)
    end
  end
end
