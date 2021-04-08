class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :timeline_id, :user_id
  
end
