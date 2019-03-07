require_relative 'handler/key_value_mapper'
require_relative 'handler/flag_builder'

module ActiveFlags
  module Flaggable
    extend ActiveSupport::Concern

    class_methods do
      def has_flags(*authorized_flags)
        has_many :flags, class_name: 'ActiveFlags::Flag', as: :subject

        define_method(:flags=) do |hash_of_flags|
          ::ActiveFlags::Handler::KeyValueMapper.remap(hash_of_flags).each do |flag_attributes|
            return unless authorized_flags.include?(flag_attributes[:key])
            ::ActiveFlags::Handler::FlagBuilder.new(self, flag_attributes).save
          end
        end
      end
    end
  end
end