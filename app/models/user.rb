class User < ApplicationRecord
  has_one :participation, -> { active }, dependent: :destroy
  has_one :lobby, through: :participation

  has_many :past_participations, -> { inactive }, class_name: 'Participation', dependent: :destroy
  has_many :past_lobbies, through: :past_participations, class_name: 'Lobby', source: :lobby
end
