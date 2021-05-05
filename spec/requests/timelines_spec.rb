require 'rails_helper'

RSpec.describe 'Timelines', type: :request do
  let(:user) { create(:user) }
  let(:timelines) { create_list(:timeline, 5, user: user, followings: followings) }

  describe 'GET /timelines' do
    context 'ログインしている場合' do
      before do 
        sign_in user
      end
      it '200ステータスが返ってくる' do
        get timelines_path
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST /timelines' do
    context 'ログインしている場合' do
      before do 
        sign_in user
      end
      it '投稿が保存される' do
        timeline_params = attributes_for(:timeline)
        post timelines_path({timeline: timeline_params})
        expect(response).to have_http_status(302)
        expect(Timeline.last.content).to eq(timeline_params[:content])
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        timeline_params = attributes_for(:timeline)
        post timelines_path({timeline: timeline_params})
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end
