class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :timeline_id, :user_id
  
  belongs_to :user
  belongs_to :profile
end
