module Api
  module V1
    class ContactsController < ApplicationController
      def show
        contact = Contacts::FetchService.call
        render json: ContactSerializer.new(contact).serializable_hash
      end

      def create
        message = Contacts::CreateMessageService.call(contact_params)
        render json: {
          data: {
            type: "contact_message",
            attributes: {
              status: "received",
              name: message[:name],
              email: message[:email]
            }
          }
        }, status: :created
      end

      private

      def contact_params
        params.require(:contact).permit(:name, :email, :message)
      end
    end
  end
end
