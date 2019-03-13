module ActiveFlags
  module Handler
    class FlagBuilder
      def initialize(resource, flag_attributes)
        @resource = resource
        @flag_attributes = flag_attributes
      end

      def save
        flag = ActiveFlags::Flag.find_by(subject: @resource, key: @flag_attributes[:key])
        flag = flag ? update_flag(flag) : create_flag
        @resource.flags_as_collection << flag
      end

      def update_flag(flag)
        flag.tap do |flag|
          flag.update!(value: @flag_attributes[:value])
        end
      end

      def create_flag
        ActiveFlags::Flag.new(subject: @resource, key: @flag_attributes[:key]) do |flag_to_create|
          flag_to_create.value = @flag_attributes[:value]
        end
      end
    end
  end
end