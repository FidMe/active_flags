require 'utils/value_stringifier'

module ActiveFlags
  class Flag < ApplicationRecord
    belongs_to :subject, polymorphic: true

    validates :subject, :key, :value, presence: true
    validates :key, uniqueness: { scope: :subject }

    after_save :notify_subject_flag_has_changed, if: proc { |flag| flag.saved_changes.key?('value') }
    def notify_subject_flag_has_changed
      subject.flag_has_changed(key, value) if subject&.respond_to?(:flag_has_changed)
      true
    end

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
