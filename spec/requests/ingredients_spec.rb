require 'rails_helper'

RSpec.describe 'Ingredients', type: :request do
  describe 'GET /new' do
    it 'returns http success' do
      get '/ingredients/new'
      expect(response).to have_http_status(:success)
    end
  end
end
