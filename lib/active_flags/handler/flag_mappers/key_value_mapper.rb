module ActiveFlags
  module Handler
    module FlagMappers
      class KeyValueMapper
        def initialize(hash_to_map)
          @hash_to_map = hash_to_map
        end

        def remap
          @hash_to_map.map do |key, value|
            { key: key, value: value }
          end
        end

        def self.remap(hash_of_flags)
          new(hash_of_flags).remap
        end
      end
    end
  end
end
