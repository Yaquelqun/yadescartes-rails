class Lobby < ApplicationRecord
  has_many :participations, dependent: :destroy
  has_many :users, through: :participations

  WAITING_FOR_PLAYERS = 'waiting_for_players'.freeze
  ONGOING = 'ongoing'.freeze
  FINISHED = 'finished'.freeze
  STATUSES = [WAITING_FOR_PLAYERS, ONGOING, FINISHED].freeze

  validates :status, inclusion: { in: STATUSES }
end
