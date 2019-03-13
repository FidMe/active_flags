module ActiveFlags
  module Handler
    class FlagBuilder
      def initialize(resource, flag_attributes)
        @resource = resource
        @flag_attributes = flag_attributes
      end

      def save
        ActiveFlags::Flag.find_or_initialize_by(subject: @resource, key: @flag_attributes[:key])
                         .update!(value: @flag_attributes[:value])
        @resource.reload
      end
    end
  end
end