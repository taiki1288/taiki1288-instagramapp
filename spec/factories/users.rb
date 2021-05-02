FactoryBot.define do
  factory :user do
    account { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password' }
  end
end
