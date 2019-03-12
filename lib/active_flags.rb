require "active_flags/engine"
require_relative 'active_flags/handler/flag_mapper'
require_relative 'active_flags/handler/flag_builder'

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
  end
end