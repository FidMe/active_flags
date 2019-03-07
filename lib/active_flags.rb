require "active_flags/engine"
require_relative 'active_flags/handler/flag_mapper'
require_relative 'active_flags/handler/flag_builder'

module ActiveFlags
  extend ActiveSupport::Concern

  class_methods do
    def has_flags(*authorized_flags)
      has_many :flags, class_name: 'ActiveFlags::Flag', as: :subject

      define_method(:flags=) do |flags|
        Handler::FlagMapper.remap(authorized_flags, flags).each do |flag_attributes|
          Handler::FlagBuilder.new(self, flag_attributes).save
        end
      end
    end
  end
end