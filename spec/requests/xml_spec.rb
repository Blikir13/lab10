require 'rails_helper'
require 'spec_helper'

RSpec.describe 'Xml', type: :request do
  describe 'GET /' do
    it 'returns http success' do
      get '/', params: { number: '1 2 3 4 1 2 3 0 9 8 7', format: :rss }
      expect(response).to have_http_status(:success)
      expect(response.headers['Content-Type']).to include('application/rss+xml')
    end

    it 'Compares two responses with different values' do
      get '/', params: { number: '1 2 3 4 1 2 3 0 9 8 7', format: :xml }
      response1 = response
      get '/', params: { number: '1 2 3 4 1 2 3 0 9 8 9', format: :xml }
      expect(response.body).not_to eq(response1.body)
    end
  end
end
