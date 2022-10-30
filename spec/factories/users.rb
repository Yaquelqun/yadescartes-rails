FactoryBot.define do
  factory :user, class: User do
    pseudo { Faker::Name.name }
    email { Faker::Internet.email }
  end
end