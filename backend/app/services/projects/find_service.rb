module Projects
  class FindService < ApplicationService
    def initialize(id_or_slug)
      @id_or_slug = id_or_slug
    end

    def call
      Project.find_by(slug: @id_or_slug) || Project.find(@id_or_slug)
    end
  end
end
