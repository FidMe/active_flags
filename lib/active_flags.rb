require "active_flags/engine"
require_relative 'active_flags/handler/flag_mapper'
require_relative 'active_flags/handler/flag_builder'
require_relative 'utils/value_stringifier'

module ActiveFlags
  extend ActiveSupport::Concern

  ACTIVE_FLAGS_PREFIX = 'flagged_as_'

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

    def respond_to_missing?(method_name, include_private = false)
      method_name.to_s.include?(ACTIVE_FLAGS_PREFIX) || super
    end

    def method_missing(method_name, *args, &block) 
      return super unless method_name.to_s.include?(prefix = ACTIVE_FLAGS_PREFIX)

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
