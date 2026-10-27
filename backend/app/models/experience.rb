class Experience < ApplicationRecord
  validates :company, :role, :started_on, presence: true

  scope :ordered, -> { order(started_on: :desc) }
end
