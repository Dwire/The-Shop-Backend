class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :topic
  belongs_to :user, dependent: :destroy
end
