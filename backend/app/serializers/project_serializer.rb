class ProjectSerializer
  include JSONAPI::Serializer

  attributes :title, :slug, :summary, :description, :tech_stack, :repo_url, :live_url, :featured, :position
end
