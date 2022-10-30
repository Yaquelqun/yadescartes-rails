class CreateLobby
  def call
    lobby = create_lobby

    lobby
  end

  private
  def create_lobby
    Lobby.create!(status: Lobby::WAITING_FOR_PLAYERS)
  end
end

