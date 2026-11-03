require_relative 'flag_mappers/key_value_mapper'
require_relative 'flag_mappers/authorizer'

module ActiveFlags
  module Handler
    class FlagMapper
      def initialize(authorized_flags = {}, flags)
        @authorized_flags = authorized_flags
        @flags = flags
      end

      # Sorted by key so that every writer locks the flag rows in the same
      # order: two concurrent transactions updating the same flags in a
      # different order would otherwise deadlock.
      def remap
        @flags = FlagMappers::Authorizer.authorize(@authorized_flags, @flags)
        FlagMappers::KeyValueMapper.remap(@flags).sort_by { |flag| flag[:key].to_s }
      end

      def self.remap(authorized_flags, flags)
        new(authorized_flags, flags).remap
      end
    end
  end
end