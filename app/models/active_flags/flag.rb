require_relative '../../../lib/utils/value_stringifier'

module ActiveFlags
  class Flag < ApplicationRecord
    belongs_to :subject, polymorphic: true

    validates :subject, :key, :value, presence: true
    validates :key, uniqueness: { scope: :subject }

    def converted_value
      self.value = unstringify(value)
    end
  end
end
