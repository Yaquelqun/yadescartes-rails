FactoryBot.define do 
  factory :lobby do
    status { ::Lobby::STATUSES.sample }
  end
end
