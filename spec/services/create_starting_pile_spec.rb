require 'rails_helper'

describe CreateStartingPile do
  describe 'call' do
    describe 'happy path' do
      it 'creates a pile'
      it 'calls the generate deck service'
    end

    context 'when the pile creation fails' do
      it 'does not call the deck creation service'
      it 'returns the creation failure exception'
    end

    context 'when the deck creation service fails' do
      it 'relays the exception'
    end
  end
end
