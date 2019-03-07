module ActiveFlags
  module Handler
    module FlagMappers
      class Authorizer
        def initialize(authorized_flags = {}, flags)
          @authorized_flags = authorized_flags
          @flags = flags
        end

        def authorize
          return @flags if @authorized_flags.empty?
          @flags.select do |flag_name, value|
            @authorized_flags.include?(flag_name)
          end
        end

        def self.authorize(authorized_flags, flags)
          new(authorized_flags, flags).authorize
        end
      end
    end
  end
end