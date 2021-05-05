require 'rails_helper'

RSpec.describe 'Accounts', type: :request do
  let!(:user) { create(:user) }
  describe 'GET /accounts' do
    context 'ログインしている場合' do
      before do 
        sign_in user
      end
      it 'プロフィール画面にリダイレクトする' do
        get account_path(id: user.id)
        expect(response).to redirect_to(profile_path)
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        get account_path(id: user.id)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
