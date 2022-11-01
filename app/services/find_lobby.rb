# FindLobby is the matchmaking service
# For now, it simply returns an open lobby
# Later, it will search the open lobbies for one
# that matches the user demands
class FindLobby
  attr_reader :initial_scope
  def initialize(initial_scope: Lobby.waiting_for_players)
    @initial_scope = initial_scope
  end

  def call
    scoped = find_oldest(initial_scope)

    scoped
  end

  private

  def find_oldest(scoped)
    scoped.order(created_at: :asc).first
  end
end
