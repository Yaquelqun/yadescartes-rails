require 'rails_helper'

describe CreateLobby do
  describe 'call' do
    subject(:service_response) do
      described_class.new.call
    rescue Errors::ApplicationError => exception
      exception
    end

    let(:user) { create(:user) }

    it 'creates an empty lobby' do
      expect(service_response.class).to eql(Lobby)
      expect(service_response.users).to be_empty
    end
  end
end

