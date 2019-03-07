require_relative 'handler/key_value_mapper'
require_relative 'handler/flag_builder'
require_relative 'handler/authorizer'

module ActiveFlags
  module Flaggable
    extend ActiveSupport::Concern

    class_methods do
      def has_flags(*authorized_flags)
        has_many :flags, class_name: 'ActiveFlags::Flag', as: :subject

        define_method(:flags=) do |flags|
          flags = ::ActiveFlags::Handler::Authorizer.authorize(authorized_flags, flags)
          ::ActiveFlags::Handler::KeyValueMapper.remap(flags).each do |flag_attributes|
            ::ActiveFlags::Handler::FlagBuilder.new(self, flag_attributes).save
          end
        end
      end
    end
  end
end