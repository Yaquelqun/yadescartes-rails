FactoryBot.define do 
  factory :lobby do
    status { ::Lobby::STATUSES.sample }

    trait :waiting_for_players do
      status { ::Lobby::WAITING_FOR_PLAYERS}
    end
  end
end

