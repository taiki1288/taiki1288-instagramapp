require 'rails_helper'

RSpec.describe 'Api::Comments', type: :request do
  let!(:user) { create(:user) }
  let!(:timeline) { create(:timeline, user: user) }
  let!(:comments) { create_list(:comment, 3, timeline: timeline, user: user) }

  describe 'GET /api/comments' do
    it '200ステータスが返ってくる' do
      get api_comments_path(timeline_id: timeline.id)
      expect(response).to have_http_status(200)
      
      # body = JSON.parse(response.body)
      # expect(body.length).to 3
      # expect(body[0]['content']).to eq comment.first.content
      # expect(body[1]['content']).to eq comment.second.content
      # expect(body[2]['content']).to eq comment.third.content
      # binding.pry 
    end
  end
end
