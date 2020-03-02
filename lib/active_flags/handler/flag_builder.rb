module ActiveFlags
  module Handler
    class FlagBuilder
      def initialize(resource, flag_attributes)
        @resource = resource
        @flag_attributes = flag_attributes
      end

      def save
        flag = ActiveFlags::Flag.find_or_initialize_by(subject: @resource, key: @flag_attributes[:key])
        if ActiveFlags::Flag.where(subject: flag.subject, key: flag.key).any?
          flag.removing_duplicated_flags
        end

        flag.update!(value: @flag_attributes[:value])

        @resource.flags_as_collection << flag
      end
    end
  end
end
