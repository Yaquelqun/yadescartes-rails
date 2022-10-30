class CreateStartingPile
  attr_reader :lobby

  def initialize(lobby:)
    @lobby = lobby
  end

  def call
    ActiveRecord::Base.transaction do
      pile = lobby.create_pile
      generate_cards_for(pile)
    end
    lobby
  end

  private

  def generate_cards_for(pile)
    Card::SUITS.each do |suit|
      Card::RANKS.each do |rank|
        pile.cards << Card.create(suit: suit, rank: rank)
      end
    end
  end
end
