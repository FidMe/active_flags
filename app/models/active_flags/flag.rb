module ActiveFlags
  class Flag < ApplicationRecord
    belongs_to :subject, polymorphic: true

    validates :subject, :key, :value, presence: true
    validates :key, uniqueness: { scope: :subject }
  end
end
