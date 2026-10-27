module Projects
  class ListService < ApplicationService
    def call
      Project.ordered
    end
  end
end
