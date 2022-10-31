# AddUserToLobby is used to add a new user to an
# existing lobby. It's in charge of starting the lobby
# once it's full.
class AddUserToLobby
  attr_reader :user, :lobby

  def initialize(user:, lobby:)
    @user = user
    @lobby = lobby
  end

  def call
    lobby.users << user
    start_lobby if lobby.ready_to_start?
  end

  private

  def start_lobby
    lobby.update(status: Lobby::ONGOING)
  end
end
