class Card < ApplicationRecord
  belongs_to :owner, polymorphic: true
  belongs_to :player, class_name: 'User', optional: true

  SPADE = 'spade'.freeze
  CLUB = 'club'.freeze
  HEART = 'heart'.freeze
  DIAMOND = 'diamond'.freeze
  SUITS = [SPADE, CLUB, HEART, DIAMOND].freeze

  RANKS = ['7', '8', '9', '10', 'jack', 'queen', 'king', 'ace'].freeze
  validates :owner_type, inclusion: { in: ['User', 'Pile', 'Trick'] }
  validates :suit, inclusion: { in: SUITS }
  validates :rank, inclusion: { in: RANKS }
end
