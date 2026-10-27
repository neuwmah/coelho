class Bio < ApplicationRecord
  validates :full_name, :headline, :summary, :summary_mobile, presence: true
end
