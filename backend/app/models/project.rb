class Project < ApplicationRecord
  validates :title, :slug, :summary, presence: true
  validates :slug, uniqueness: true

  scope :featured, -> { where(featured: true) }
  scope :ordered, -> { order(position: :asc, created_at: :desc) }
end
