require 'rails_helper'

RSpec.describe ApplicationController do
  describe 'current_user' do
    context 'without the proper headers' do
      it 'fails' do
        expect { controller.current_user }.to raise_error ::ActiveRecord::RecordNotFound
      end
    end

    context 'with a proper header' do
      let(:user) { create(:user) }

      before do 
        request&.headers&.merge!({ Authorization: "Bearer #{user.email}" })
      end

      it { expect(controller.current_user).not_to be_nil }

      it 'returns the user' do
        expect(controller.current_user.id).to eql user.id
      end
    end
  end
end

