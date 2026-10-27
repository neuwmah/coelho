class ExperienceSerializer
  include JSONAPI::Serializer

  attributes :company, :role, :location, :started_on, :ended_on, :current, :description, :highlights
end
