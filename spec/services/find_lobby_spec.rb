require 'rails_helper'

describe FindLobby do
  describe 'call' do
    context 'with a free user' do
      context 'when a free lobby exists' do
        it 'adds the user to the lobby'
        it 'returns the joined lobby'

        context 'when the lobby is now full' do
          it 'updates the lobby status'
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