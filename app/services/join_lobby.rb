# Join Lobby is the orchestrator service used to find an 
# appropriate lobby for a given user and add said user to 
# said lobby. It's basically the service associated with the
# "Start Game" button
class JoinLobby
  attr_reader :user

  def initialize(user:)
    @user = user
    return if @user

    raise Errors::MissingArgument.new(argument: 'user')
  end

  def call
    check_user_availability
    lobby = find_or_create_lobby
    add_user_to(lobby)
    lobby
  end

  private

  def check_user_availability
    return unless user.busy?

    raise Errors::ApplicationError.new(status: :unprocessable_entity, message: 'user_already_in_lobby')
  end

  def find_or_create_lobby
    FindLobby.new.call || CreateLobby.new.call
  end

  def add_user_to(lobby)
    AddUserToLobby.new(user: user, lobby: lobby).call
  end
end
