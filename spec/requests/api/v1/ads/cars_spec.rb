require 'rails_helper'

RSpec.describe 'Api::V1::Ads::CarsController', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get api_v1_ads_cars_path(format: :json)

      expect(response).to have_http_status(:success)
    end

    it 'should turn the page' do
      get api_v1_ads_cars_path(format: :json), params: { page: 2 }

      expect(response).to have_http_status(:success)
    end
  end
end
