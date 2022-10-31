# FindLobby is the matchmaking service
# For now, it simply returns an open lobby
# Later, it will search the open lobbies for one 
# that matches the user demands
class FindLobby
  def call
    Lobby.oldest_waiting_for_players
  end
end
