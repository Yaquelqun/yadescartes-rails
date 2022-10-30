require 'rails_helper'

describe CreateLobby do
  describe 'call' do
    subject(:service_response) do
      described_class.new(**service_arguments).call
    rescue Errors::ApplicationError => exception
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
        expect(service_response.users.ids).to eql [user.id]
      end
    end

    context 'without arguments' do
      let(:service_arguments) { { user_id: nil } }

      it 'raises an error' do
        expect { service_response }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context 'when given a busy user' do
      let(:lobby) { create(:lobby, users: [user]) }
      let(:service_arguments) { { user_id: user.id } }

      before do
        lobby
      end

      it 'raises an application error' do
        expect(service_response.class).to eql(Errors::ApplicationError)
        expect(service_response.message).to eql('user_already_in_lobby')
      end

      it 'does not create a lobby' do
        expect { service_response }.not_to change(Lobby, :count)
      end
    end
  end
end