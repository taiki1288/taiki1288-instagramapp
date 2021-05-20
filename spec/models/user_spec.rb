# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  account                :string           default(""), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_account               (account) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'account、email、passwordが入力されている場合' do
    let!(:user) { create(:user) }
    it 'ユーザーを作成できる' do
      expect(user).to be_valid
    end
  end

  context 'account名が入力されてない場合' do
    let!(:user) { build(:user, account: nil)}
    before do
      user.save
    end
    it 'ユーザー登録できない' do
      expect(user.errors.messages[:account][0]).to eq("can't be blank")
    end
  end

  context 'メールアドレスが入力されてない場合' do
    let!(:user) { build(:user, email: nil) }
    before do
      user.save
    end
    it 'ユーザー登録できない' do
      expect(user.errors.messages[:email][0]).to eq("can't be blank")
    end
  end

  context 'パスワードが入力されていない場合' do
    let!(:user) { build(:user, password: nil) }
    before do
      user.save
    end
    it 'ユーザー登録できない' do
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
