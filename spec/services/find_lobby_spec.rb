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
        let(:lobbies) { create_list(:lobby, 5, status: Lobby::FINISHED) }

        before do
          lobbies
        end

        it 'creates a new lobby' do
          expect { service_response }.to change(Lobby, :count).by(1)
          expect(lobbies.pluck(:id)).not_to include(user.reload.lobby.id)
        end

        it 'returns the newly created lobby' do
          expect(service_response.id).to eql(user.reload.lobby.id)
        end
      end
    end

    context 'without argument' do
      let(:service_arguments) { { user_id: nil } }

      it 'raises an error' do
        expect { service_response }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context 'with a busy user' do
      let(:lobby) { create(:lobby, users: [user]) }
      
      before do
        lobby
      end

      it 'raises an error' do
        expect(service_response.class).to eql Errors::ApplicationError
      end

      it 'does not create a new participation' do
        expect { service_response }.to change(Participation, :count).by(0)
      end
    end
  end
end

