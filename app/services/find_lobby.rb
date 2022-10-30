class FindLobby
  attr_reader :user_id

  def initialize(user_id:)
    @user_id = user_id
  end

  def call
    check_user_availability
    available_lobby.users << user
    available_lobby
  end

  private

  def check_user_availability
    return unless user.busy?

    raise Errors::ApplicationError.new(status: :unprocessable_entity, message: 'user_already_in_lobby')
  end

  def available_lobby
    @available_lobby ||= Lobby.waiting_for_players.order(created_at: :asc).first || CreateLobby.new.call
  end

  def user
    @user ||= User.find(user_id)
  end
end
