require 'rails_helper'

describe FindLobby do
  describe 'call' do
    subject(:service_response) do
      described_class.new(**service_arguments).call
    rescue Errors::ApplicationError => exception
      exception
    end

    let(:user) { create(:user) }
    let(:service_arguments) { { user_id: user.id } }

    context 'with a free user' do
      context 'when a free lobby exists' do
        let(:lobby) { create(:lobby, status: Lobby::WAITING_FOR_PLAYERS) }
        let(:users) { create_list(:user, 2) }

        before do
          lobby.users << users
        end

        it 'adds the user to the lobby' do
          service_response
          expect(lobby.users.ids).to include(user.id)
        end

        it 'returns the joined lobby' do
          expect(service_response.id).to eql lobby.id
        end

        context 'when the lobby is now full' do
          let(:users) { create_list(:user, 3) }

          it 'updates the lobby status' do
            service_response
            expect(lobby.reload.status).to eql(Lobby::ONGOING)
          end
        end
      end

      context 'when no free lobby is available' do
        it 'creates a new lobby'
        it 'returns the newly created lobby'
      end
    end

    context 'without argument' do
      it 'raises an error'
    end

    context 'with a busy user' do
      it 'raises an error'
      it 'does not create a new participation'
    end
  end
end