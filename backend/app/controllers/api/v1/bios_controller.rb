module Api
  module V1
    class BiosController < ApplicationController
      def show
        bio = Bios::FetchService.call
        render json: BioSerializer.new(bio).serializable_hash
      end
    end
  end
end
