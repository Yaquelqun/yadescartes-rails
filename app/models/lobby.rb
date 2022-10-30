class Lobby < ApplicationRecord
  has_many :participations, dependent: :destroy
  has_many :users, through: :participations

  WAITING_FOR_PLAYERS = 'waiting_for_players'.freeze
  ONGOING = 'ongoing'.freeze
  FINISHED = 'finished'.freeze
  STATUSES = [WAITING_FOR_PLAYERS, ONGOING, FINISHED].freeze

  MAX_PLAYERS = 4

  validates :status, inclusion: { in: STATUSES }

  scope :waiting_for_players, -> { where(status: WAITING_FOR_PLAYERS) }
  scope :ongoing, -> { where(status: ONGOING) }
  scope :finished, -> { where(status: FINISHED) }

  def check_for_start
    update(status: ONGOING) if participations.count == MAX_PLAYERS
  end
end
