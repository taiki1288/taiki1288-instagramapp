require 'rails_helper'

RSpec.describe 'Timeline', type: :system do
    it '投稿一覧が表示される' do
        visit root_path
    end
end