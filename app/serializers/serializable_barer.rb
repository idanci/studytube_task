class SerializableBearer < JSONAPI::Serializable::Resource
  type 'bearer'
  attributes :name
end
