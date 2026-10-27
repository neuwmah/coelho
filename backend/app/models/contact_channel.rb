class ContactChannel < ApplicationRecord
  validates :title, :subtitle, :icon, presence: true

  scope :ordered, -> { order(position: :asc) }
end
