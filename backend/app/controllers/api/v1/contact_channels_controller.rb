module Api
  module V1
    class ContactChannelsController < ApplicationController
      def index
        channels = ContactChannels::ListService.call
        render json: ContactChannelSerializer.new(channels).serializable_hash
      end
    end
  end
end
