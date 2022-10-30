class User < ApplicationRecord
  has_one :participation, -> { active }
  has_one :lobby, through: :participation

  has_many :past_participations, -> { inactive }, class_name: 'Participation'
  has_many :past_lobbies, through: :past_participations, class_name: 'Lobby', source: :lobby
end
