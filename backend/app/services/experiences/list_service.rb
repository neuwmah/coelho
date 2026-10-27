module Experiences
  class ListService < ApplicationService
    def call
      Experience.ordered
    end
  end
end
