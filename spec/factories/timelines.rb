# == Schema Information
#
# Table name: timelines
#
#  id         :bigint           not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_timelines_on_user_id  (user_id)
#
FactoryBot.define do
    factory :timeline do
        content { Faker::Lorem.sentence(word_count: 10) }
    end
end
