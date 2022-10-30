class CreateLobby
  attr_reader :user_id

  def initialize(user_id:)
    @user_id = user_id
  end

  def call
    check_user_availability
    lobby = create_lobby
    add_user_to(lobby)

    lobby
  end

  private

  def check_user_availability
    return unless user.busy?

    raise Errors::ApplicationError.new(status: :unprocessable_entity, message: 'user_already_in_lobby')
  end

  def create_lobby
    Lobby.create!(status: Lobby::WAITING_FOR_PLAYERS)
  end

  def add_user_to(lobby)
    lobby.users << user
  end

  def user
    @user ||= User.find(user_id)
  end
end
