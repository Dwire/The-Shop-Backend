class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :guru, :project
end
