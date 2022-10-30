class FindLobby
  attr_reader :user_id

  def initialize(user_id:)
    @user_id = user_id
  end

  def call
    available_lobby.users << user
    available_lobby
  end

  private

  def available_lobby
    @available_lobby ||= Lobby.waiting_for_players.order(created_at: :asc).first || CreateLobby.new.call
  end

  def user
    @user ||= User.find(user_id)
  end
end
