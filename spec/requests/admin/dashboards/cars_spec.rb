require 'rails_helper'

RSpec.describe "Admin::Dashboards::Homes", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admin/dashboards/home/index"
      expect(response).to have_http_status(:success)
    end
  end
end
