class CreateLobby
  attr_reader :lobby_params

  def initialize(lobby_params: {})
    @lobby_params = lobby_params
  end

  def call
    ActiveRecord::Base.transaction do
      create_starting_pile
      lobby
    end
  end

  private

  def lobby
    @lobby ||= Lobby.create!(status: Lobby::WAITING_FOR_PLAYERS, **lobby_params)
  end

  def create_starting_pile
    CreateStartingPile.new(lobby: lobby).call
  end
end
