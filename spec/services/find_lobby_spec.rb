require 'rails_helper' 

describe FindLobby do
  describe 'call' do
    let(:lobbies) { create_list(:lobby, 10, :waiting_for_players)}

    it 'makes a request' do
      byebug
      expect { describe_class.new.call }.to make_database_queries
    end
  end
end