FactoryBot.define do
  factory :participation do
    association :user
    association :lobby
  end
end
