require 'utils/value_stringifier'

module ActiveFlags
  class Flag < ApplicationRecord
    belongs_to :subject, polymorphic: true

    validates :subject, :key, :value, presence: true
    validates :key, uniqueness: { scope: :subject }

    def removing_duplicated_needed?
      ActiveFlags::Flag.where(subject: subject, key: key).any?
    end

    def removing_duplicated_flags!
      return false unless removing_duplicated_needed?
      grouped = ActiveFlags::Flag
        .where(subject_id: subject_id, subject_type: subject_type, key: key)
        .group_by { |model| [model.key, model.subject_id, model.subject_type] }
      grouped.values.each do |duplicates|
        duplicates.shift
        duplicates.each(&:destroy)
      end
      true
    end

    def converted_value
      self.value = unstringify(value)
    end
  end
end
