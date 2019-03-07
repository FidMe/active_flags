module ActiveFlags
  module Handler
    class FlagBuilder
      def initialize(resource, flag_attributes)
        @resource = resource
        @flag_attributes = flag_attributes
      end

      def save
        @resource.flags << ActiveFlags::Flag.find_or_initialize_by(subject: @resource, key: @flag_attributes[:key]) do |flag_to_create|
          flag_to_create.value = @flag_attributes[:value]
        end
      end
    end
  end
end