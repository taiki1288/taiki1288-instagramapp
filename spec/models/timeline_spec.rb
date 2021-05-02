require 'rails_helper'

RSpec.describe Timeline, type: :model do
  let!(:user) { create(:user) }

  context '内容が保存されている場合' do

    let!(:timeline) { build(:timeline, user: user) }

    it '投稿を保存できる' do
      expect(timeline).to be_valid
    end
  end

  context '内容が入力されていない場合' do
    let!(:timeline) { build(:timeline, content: '', user: user)}

    before do
      timeline.save
    end
    
    it '記事を保存できない' do
      expect(timeline.errors.messages[:content][0]).to eq("can't be blank")
    end
  end
end
