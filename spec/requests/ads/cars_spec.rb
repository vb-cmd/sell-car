require 'rails_helper'

RSpec.describe "Ads::CarsController", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get ads_cars_path
      expect(response).to have_http_status(:success)
    end
  end
end
