class ContactSerializer
  include JSONAPI::Serializer

  attributes :email, :phone, :location, :linkedin_url, :github_url, :twitter_url
end
