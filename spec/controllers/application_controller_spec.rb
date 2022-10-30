require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let(:user) { create(:user) }

  describe 'current_user' do
    context 'without the proper headers' do
      it 'fails' do
        expect { controller.current_user }.to raise_error ::Errors::Unauthorized
      end
    end

    context 'with a proper header' do
      before do 
        request&.headers&.merge!({ Authorization: "Bearer #{user.email}" })
      end

      it { expect(controller.current_user).not_to be_nil }

      it 'returns the user' do
        expect(controller.current_user.id).to eql user.id
      end
    end
  end

  describe 'authentication behavior' do
    subject { response }

    controller do
      def index
        render json: { id: current_user.id }, status: :ok
      end
    end

    context 'without proper headers' do
      before do
        get :index
      end

      it { is_expected.to be_unauthorized }
    end

    context 'with proper headers' do
      before do
        request&.headers&.merge!({ Authorization: "Bearer #{user.email}" })
        get :index
      end

      it 'returns the user' do
        expect(JSON.parse(response.body)['id']).to eql user.id
      end
    end
  end
end

