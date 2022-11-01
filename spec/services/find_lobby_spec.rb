require 'rails_helper' 

describe FindLobby do
  describe 'call' do
    let(:lobbies) { create_list(:lobby, 10, :waiting_for_players)}

    before do
      lobbies
    end

    # TODO: Reaaaaally sus test.
    it 'makes a request' do
      expect(described_class.new.call).to eql lobbies.first
    end
  end
end
