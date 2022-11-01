require 'rails_helper'

describe JoinLobby do
  describe 'call' do
    subject(:service_response) do
      described_class.new(**service_arguments).call
    rescue StandardError => exception
      exception
    end

    let(:user) { build(:user) }
    let(:lobby) { build(:lobby, status: Lobby::WAITING_FOR_PLAYERS) }

    let(:service_arguments) { { user: user } }

    # TODO: Put in contexts (mocked lobby behaviours for example)
    let(:find_lobby_double) { instance_double(FindLobby) }
    let(:find_lobby_behaviour) { receive(:call).and_return nil }

    let(:create_lobby_double) { instance_double(CreateLobby) }
    let(:create_lobby_behaviour) { receive(:call).and_return nil }

    let(:add_user_to_lobby_double) { instance_double(AddUserToLobby) }
    let(:add_user_to_lobby_behaviour) { receive(:call).and_return nil }

    before do
      allow(FindLobby).to receive(:new).and_return find_lobby_double
      allow(find_lobby_double).to find_lobby_behaviour

      allow(CreateLobby).to receive(:new).and_return create_lobby_double
      allow(create_lobby_double).to create_lobby_behaviour

      allow(AddUserToLobby).to receive(:new).and_return add_user_to_lobby_double
      allow(add_user_to_lobby_double).to add_user_to_lobby_behaviour
    end

    context 'with a free user' do
      context 'when a free lobby exists' do
        let(:find_lobby_behaviour) { receive(:call).and_return(lobby) }

        it 'succeeds' do
          expect { service_response }.not_to raise_error
        end

        it { is_expected.to eql lobby }

        it 'does not call the create lobby service' do
          service_response
          expect(create_lobby_double).not_to have_received(:call)
        end

        it 'calls the right services' do
          service_response
          expect(find_lobby_double).to have_received(:call)
          expect(add_user_to_lobby_double).to have_received(:call)
        end
      end

      context 'when no free lobby is available' do
        let(:create_lobby_behaviour) { receive(:call).and_return lobby }

        it 'succeeds' do
          expect { service_response }.not_to raise_error
        end

        it { is_expected.to eql lobby }

        it 'calls the create_lobby service' do
          service_response
          expect(create_lobby_double).to have_received(:call)
        end
      end
    end

    context 'without argument' do
      let(:service_arguments) { { user: nil } }

      it { is_expected.to be_a Errors::MissingArgument }
    end

    context 'with a busy user' do
      let(:user) { build(:user, :busy) }

      it { is_expected.to be_a Errors::ApplicationError }

      it 'returns the right error message' do
        expect(service_response.message).to eql 'user_already_in_lobby'
      end

      it 'does not call any sub service' do
        expect(find_lobby_double).not_to have_received(:call)
        expect(create_lobby_double).not_to have_received(:call)
        expect(add_user_to_lobby_double).not_to have_received(:call)
      end
    end

    # TODO: Refactor using a shared context and it_behaves_like
    context 'when a subservice goes wrong' do
      let(:exception) { Errors::ApplicationError.new(status: :nok, message: 'oh no') }

      context 'when FindLobby fails' do
        let(:find_lobby_behaviour) { receive(:call).and_raise exception }

        it 'relays the exception' do
          expect(service_response).to eql exception
        end
      end

      context 'when CreateLobby fails' do
        let(:create_lobby_behaviour) { receive(:call).and_raise exception }

        it 'relays the exception' do
          expect(service_response).to eql exception
        end
      end

      context 'when AddUserToLobby fails' do
        let(:add_user_to_lobby_behaviour) { receive(:call).and_raise exception }

        it 'relays the exception' do
          expect(service_response).to eql exception
        end
      end
    end
  end
end

