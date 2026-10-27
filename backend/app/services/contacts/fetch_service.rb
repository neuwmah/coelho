module Contacts
  class FetchService < ApplicationService
    def call
      Contact.order(updated_at: :desc).first!
    end
  end
end
