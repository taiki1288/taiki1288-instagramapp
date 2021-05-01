require 'rails_helper'

RSpec.describe User, type: :model do
  context 'account、email、passwordが入力されている場合' do
    let!(:user) { create(:user) }
    it 'ユーザーを作成できる' do
      expect(user).to be_valid
    end
  end

  context 'account名が入力されてない場合' do
    let!(:user) { create(:user) }
    it 'ユーザー登録できない' do
      user = FactoryBot.build(:user, account: nil)
      user.valid?
      expect(user.errors.messages[:account][0]).to eq("can't be blank")
    end
  end

  context 'メールアドレスが入力されてない場合' do
    let!(:user) { create(:user) }
    it 'ユーザー登録できない' do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors.messages[:email][0]).to eq("can't be blank")
    end
  end

  context 'パスワードが入力されていない場合' do
    let!(:user) { create(:user) }
    it 'ユーザー登録できない' do
      user = FactoryBot.build(:user, password: nil)
      user.valid?
      expect(user.errors.messages[:password][0]).to eq("can't be blank")
    end
  end

  context '同じaccount名の場合' do
    user = User.create({
      email: 'test@example.com',
      account: 'account',
      password: 'password'
    })

    user2 = User.create({
      email: 'test@example.com',
      account: 'account',
      password: 'aaaaaaaa'
    })

    it 'ユーザー登録できない' do
      expect(user2.errors.messages[:account][0]).to eq("has already been taken")
    end
  end
end
