require 'rails_helper'

describe CreateLobby do
  describe 'call' do
    subject(:service_response) do
      described_class.new(**service_arguments).call
    rescue ApplicationError => exception
      exception
    end

    let(:user) { create(:user) }

    context 'when given a free user' do
      let(:service_arguments) { { user_id: user.id} }

      it 'does not raise an error' do
        expect { described_class.new(**service_arguments).call }.not_to raise_error
      end

      it 'creates a lobby and returns it' do
        expect(service_response.class).to eql Lobby
      end

      it 'adds the user as a participant in the lobby' do
        expect(service_response.users.id).to eql [user.id]
      end
    end

    context 'without arguments' do
      let(:service_arguments) { { user_id: nil } }

      it 'raises an error' do
        expect(service_response.class).to eql(ApplicationError)
      end

      it 'does not create a lobby' do
        expect { service_response }.not_to change(Lobby, :count)
      end
    end

    context 'when given a busy user' do
      let(:lobby) { create(:lobby, users: [user]) }
      let(:service_arguments) { { user_id: user.id } }

      it 'raises an application error' do
        expect(service_response.class).to eql(ApplicationError)
        expect(service_response.messages).to eql('user_already_in_lobby')
      end

      it 'does not create a lobby' do
        expect { service_response }.not_to change(Lobby, :count)
      end
    end
  end
end