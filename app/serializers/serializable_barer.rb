# frozen_string_literal: true

class SerializableBearer < JSONAPI::Serializable::Resource
  type 'bearer'
  attributes :name
end
