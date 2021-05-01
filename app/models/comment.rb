# == Schema Information
#
# Table name: comments
#
#  id          :bigint           not null, primary key
#  content     :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  timeline_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_comments_on_timeline_id  (timeline_id)
#  index_comments_on_user_id      (user_id)
#
class Comment < ApplicationRecord
    belongs_to :timeline
    belongs_to :user
    validates :content, presence: true

    after_create :send_email

    private
    def send_email
        RelationshipMailer.new_comment(user, content).deliver_later
    end
end
