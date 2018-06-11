class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :topic
end
