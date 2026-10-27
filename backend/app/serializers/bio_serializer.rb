class BioSerializer
  include JSONAPI::Serializer

  attributes :full_name, :headline, :summary, :summary_mobile, :location, :skills, :avatar_url, :resume_url
end
