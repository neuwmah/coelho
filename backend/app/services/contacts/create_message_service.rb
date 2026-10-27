module Contacts
  class CreateMessageService < ApplicationService
    def initialize(params)
      @params = params
    end

    def call
      message = ContactMessage.create!(@params)
      {
        name: message.name,
        email: message.email,
        message: message.message
      }
    end
  end
end
