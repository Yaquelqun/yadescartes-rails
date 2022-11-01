class GenerateDeck
  attr_reader :pile

  def initialize(pile:)
    @pile = pile
  end

  def call
    Card::SUITS.each do |suit|
      Card::RANKS.each do |rank|
        Card.create!(suit: suit, rank: rank, owner: pile)
      end
    end

    pile
  end
end
