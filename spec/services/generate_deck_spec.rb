require 'rails_helper'

describe GenerateDeck do
  describe 'call' do
    subject(:service_response) { described_class.new(**service_arguments).call }

    let(:pile) { build(:pile) }
    let(:service_arguments) { { pile: pile } }

    let(:card_creation_behaviour) { receive(:create!).and_return(build(:card, owner: pile)) }

    before do
      allow(Card).to card_creation_behaviour
    end

    describe 'happy path' do
      it 'creates 32 cards' do
        service_response
        expect(Card).to have_received(:create!).exactly(32).times.with(
          hash_including(owner: pile)
        )
      end

      it { is_expected.to eql pile }
    end

    context 'when a card creation fails ' do
      let(:card_creation_behaviour) { receive(:create!).and_raise 'oh no' }

      it 'relays the exception' do
        expect { service_response }.to raise_error 'oh no'
      end
    end
  end
end
