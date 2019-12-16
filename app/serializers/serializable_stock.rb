# frozen_string_literal: true

class SerializableStock < JSONAPI::Serializable::Resource
  type 'stock'

  attributes :name

  attribute :bearer_name do
    @object.bearer.name
  end
end
