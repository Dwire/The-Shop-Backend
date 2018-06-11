class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :guru, :project
  has_many :posts 
end
