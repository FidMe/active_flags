require_relative 'flaggable'

module ActiveFlags
  class Engine < ::Rails::Engine
    isolate_namespace ActiveFlags
    config.to_prepare do
      ActiveRecord::Base.include ActiveFlags::Flaggable
    end
  end
end
