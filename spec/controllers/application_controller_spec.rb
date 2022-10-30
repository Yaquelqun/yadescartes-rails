require 'rails_helper'

RSpec.describe ApplicationController do
  context 'without the proper headers' do
    it 'fails' do
      expect { controller.current_user }.to raise_error ::ActiveRecord::RecordNotFound
    end
  end
end

