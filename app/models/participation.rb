# TODO: This class is going to be used for 2 purposes: 
# - Signify the participation of a user in a lobby
# - Signify that it's the user's turn to play using
# the active boolean. Maybe those 2 should be separated
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

