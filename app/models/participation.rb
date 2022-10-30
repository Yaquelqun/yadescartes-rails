class Participation < ApplicationRecord
  belongs_to :lobby
  belongs_to :user

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where.not(active: true) }

  after_create :check_lobby_for_start

  def check_lobby_for_start
    lobby.check_for_start
  end
end
