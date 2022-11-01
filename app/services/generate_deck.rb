class GenerateDeck
  attr_reader :pile

  def initialize(pile)
    @pile = pile
  end

  def call
    Card::SUITS.each do |suit|
      Card::RANKS.each do |rank|
        Card.create(suit: suit, rank: rank, pile: pile)
      end
    end
  end
end