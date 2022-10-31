class CreateLobby
  def call
    create_starting_pile
    lobby
  end

  private

  def lobby
    @lobby ||= Lobby.create!(status: Lobby::WAITING_FOR_PLAYERS)
  end

  def create_starting_pile
    CreateStartingPile.new(lobby: lobby).call
  end
end
