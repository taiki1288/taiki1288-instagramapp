FactoryBot.define do
    factory :timeline do
        content { Faker::Lorem.sentence(word_count: 10) }
    end
end