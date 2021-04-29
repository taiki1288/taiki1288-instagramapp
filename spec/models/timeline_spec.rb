require 'rails_helper'

RSpec.describe Timeline, type: :model do
  it '内容が入力されていれば、投稿を保存できる' do
    user = User.create!({
      email: 'test@example.com',
      password: 'password'
    })
    timeline = user.timelines.build({
      content: Faker::Lorem.characters(number: 50)
    })

    expect(timeline).to be_valid
  end
end
