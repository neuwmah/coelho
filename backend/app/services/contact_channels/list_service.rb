module ContactChannels
  class ListService < ApplicationService
    def call
      ContactChannel.ordered
    end
  end
end
