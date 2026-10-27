class ContactChannelSerializer
  include JSONAPI::Serializer

  attributes :title, :subtitle, :icon, :href, :position
end
