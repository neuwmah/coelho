module Bios
  class FetchService < ApplicationService
    def call
      Bio.order(updated_at: :desc).first!
    end
  end
end
