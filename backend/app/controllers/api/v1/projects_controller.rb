module Api
  module V1
    class ProjectsController < ApplicationController
      def index
        projects = Projects::ListService.call
        render json: ProjectSerializer.new(projects).serializable_hash
      end

      def show
        project = Projects::FindService.call(params[:id])
        render json: ProjectSerializer.new(project).serializable_hash
      end
    end
  end
end
