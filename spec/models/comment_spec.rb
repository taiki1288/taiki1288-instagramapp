require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) { create(:user) }
  let!(:timeline) { build(:timeline, user: user) }
  
  context 'コメントが保存されている場合' do

    let!(:comment) { build(:comment, timeline: timeline, user: user) }

    it '投稿を保存できる' do
      expect(comment).to be_valid
    end
  end

  context 'コメントが入力されてない場合' do
    let!(:comment) { build(:comment, content: nil, user: user, timeline: timeline)}
  
    before do
      comment.save
    end

    it 'コメントが保存できない' do
      expect(comment.errors.messages[:content][0]).to eq("can't be blank")
    end
  end
end
