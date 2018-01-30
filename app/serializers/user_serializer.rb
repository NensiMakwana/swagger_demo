class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :api_key, :created_at
end