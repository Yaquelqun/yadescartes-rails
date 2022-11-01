# CreateStartingPile creates the pile for the lobby
# and calls another service to generate the deck that we'll play with.
# If initializing a lobby is more complicated later, we could
# rename this service InitializeLobbyDependencies 
# and maybe call it from a job
class CreateStartingPile
  attr_reader :lobby

  def initialize(lobby:)
    @lobby = lobby
  end

  def call
    ActiveRecord::Base.transaction do
      pile = Pile.create!(lobby: lobby)

      GenerateDeck.new(pile: pile).call
    end
    lobby
  end
end
