require 'rails_helper'

RSpec.describe "Admin::Users::Sessions", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/admin/users/sessions/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/admin/users/sessions/create"
      expect(response).to have_http_status(:success)
    end
  end

end
