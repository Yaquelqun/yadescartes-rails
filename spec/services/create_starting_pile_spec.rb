require 'rails_helper'

describe CreateStartingPile do
  describe 'call' do
    subject(:service_response) { described_class.new(**service_arguments).call }

    let(:lobby) { build(:lobby) }
    let(:pile) { build(:pile, lobby: lobby) }
    let(:service_arguments) { { lobby: lobby } }

    let(:pile_creation_behaviour) { receive(:create!).and_return(pile) }

    let(:generate_deck_double) { instance_double(GenerateDeck) }
    let(:generate_deck_behaviour) { receive(:call).and_return(true) }

    before do 
      allow(Pile).to pile_creation_behaviour

      allow(GenerateDeck).to receive(:new).and_return(generate_deck_double)
      allow(generate_deck_double).to generate_deck_behaviour
    end

    describe 'happy path' do
      it 'succeeds' do
        expect { service_response }.not_to raise_error
      end

      it 'creates a pile for the given lobby' do
        service_response
        expect(Pile).to have_received(:create!).with(hash_including(lobby: lobby))
      end

      it 'calls the generate deck service' do
        service_response
        expect(generate_deck_double).to have_received(:call).once
      end
    end

    context 'when the pile creation fails' do
      let(:pile_creation_behaviour) { receive(:create!).and_raise 'oh no' }

      it 'returns the creation failure exception' do
        expect { service_response }.to raise_error 'oh no'
        # TODO: Find out how to extract this in another it and ignore the call
        expect(generate_deck_double).not_to have_received(:call)
      end
    end

    context 'when the deck creation service fails' do
      let(:generate_deck_behaviour) { receive(:call).and_raise 'oh no' }

      it 'relays the exception' do
        expect { service_response }.to raise_error 'oh no'
      end
    end
  end
end
