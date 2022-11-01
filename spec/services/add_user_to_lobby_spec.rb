require 'rails_helper'

describe AddUserToLobby do
  describe 'call' do
    subject(:service_response) { described_instance.call }

    let(:user) { build(:user) }
    let(:lobby) { build(:lobby, :waiting_for_players) }
    let(:described_instance) { described_class.new(**service_arguments) }
    let(:service_arguments) { { user: user, lobby: lobby } }

    let(:participation_creation_behaviour) { receive(:create!).and_return(nil) }
    let(:lobby_update_behaviour) { receive(:update!).and_return(true) }
    let(:lobby_ready_to_start) { false }

    before do
      allow(Participation).to participation_creation_behaviour
      allow(lobby).to lobby_update_behaviour
      allow(lobby).to receive(:ready_to_start?).and_return lobby_ready_to_start
    end

    describe 'happy path' do
      it 'succeeds' do
        expect { :service_response }.not_to raise_error
      end

      it { is_expected.to be_a Lobby }

      it 'creates a participation' do
        service_response
        expect(Participation).to have_received(:create!).with(
          hash_including(user: user, lobby: lobby)
        )
      end

      context 'when the lobby was one player off' do
        let(:lobby_ready_to_start) { true }

        it 'updates the lobby' do
          service_response
          expect(lobby).to have_received(:update!).with(hash_including(:status))
        end
      end
    end

    context 'when an argument is missing' do
      context 'when lobby is missing' do
        let(:service_arguments) { { user: user, lobby: nil } }

        it 'raises an exception' do
          expect { service_response }.to raise_error Errors::MissingArgument
        end
      end

      context 'when user is missing' do
        let(:service_arguments) { { user: nil, lobby: lobby } }

        it 'raises an exception' do
          expect { service_response }.to raise_error Errors::MissingArgument
        end
      end
    end

    context 'when adding the user to the lobby fails' do
      let(:participation_creation_behaviour) { receive(:create!).and_raise('oh no') }

      it 'raises an exception' do
        expect { service_response }.to raise_error 'oh no'
      end
    end

    context 'when starting the lobby fails' do
      let(:lobby_ready_to_start) { true }

      before do
        allow(described_instance).to receive(:start_lobby).and_raise('oh no')
      end

      it 'raises an exception' do
        expect { service_response }.to raise_error 'oh no'
      end
    end
  end
end
