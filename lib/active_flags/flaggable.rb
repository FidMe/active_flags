module ActiveFlags
  module Flaggable
    extend ActiveSupport::Concern

    class_methods do
      def acts_as_flaggable
        has_many :flags, class_name: 'ActiveFlags::Flag', as: :subject

        define_method(:flags=) do |array_of_flags|
          array_of_flags.each do |flag|
            flag = set_key_value(flag) if flag.count == 1
            self.flags << ActiveFlags::Flag.find_or_initialize_by(subject: self, key: flag[:key]) do |flag_to_create|
              flag_to_create.value = flag[:value]
            end
          end
        end

        define_method(:set_key_value) do |flag|
          sorted_flags = {}
          flag.each do |key, value|
            sorted_flags[:key] = key
            sorted_flags[:value] = value
          end
          sorted_flags
        end
      end
    end
  end
end