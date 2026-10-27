class Contact < ApplicationRecord
  validates :email, :location, presence: true
end
