require 'rails_helper'

describe CreateLobby do
  describe 'call' do
    subject(:service_response) do
      described_class.new.call
    rescue Errors::ApplicationError => exception
      exception
    end

    let(:lobby) { build(:lobby) }

    # TODO: Put in contexts
    let(:create_starting_pile_double) { instance_double(CreateStartingPile) }
    let(:create_starting_pile_behaviour) { receive(:call).and_return nil }

    let(:lobby_creation_response) { receive(:create!).and_return lobby }

    before do
      allow(CreateStartingPile).to receive(:new).and_return create_starting_pile_double
      allow(create_starting_pile_double).to create_starting_pile_behaviour

      allow(Lobby).to lobby_creation_response
    end

    describe 'happy path' do
      it 'creates an empty lobby' do
        expect(service_response.class).to eql(Lobby)
      end

      it 'creates the starting pile' do
        service_response
        expect(create_starting_pile_double).to have_received(:call)
      end
    end

    context 'when the creation fails' do
      let(:exception) { ActiveRecord::RecordInvalid.new }
      let(:lobby_creation_response) { receive(:create!).and_raise exception }

      it 'raises an exception' do
        expect { described_class.new.call }.to raise_error exception
      end
    end

    context 'when CreateStartingPile fails' do
      let(:exception) { Errors::ApplicationError.new }
      let(:create_starting_pile_behaviour) { receive(:call).and_raise exception }

      it { is_expected.to eql exception }
    end
  end
end

