module Api
  module V1
    class ExperiencesController < ApplicationController
      def index
        experiences = Experiences::ListService.call
        render json: ExperienceSerializer.new(experiences).serializable_hash
      end
    end
  end
end
