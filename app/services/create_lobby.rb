class CreateLobby
  def call
    lobby
  end

  private

  def lobby
    @lobby ||= Lobby.create!(status: Lobby::WAITING_FOR_PLAYERS)
  end
end
