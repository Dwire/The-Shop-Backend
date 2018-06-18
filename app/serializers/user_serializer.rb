class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :guru, :project, :longitude, :latitude
  has_many :posts
end
