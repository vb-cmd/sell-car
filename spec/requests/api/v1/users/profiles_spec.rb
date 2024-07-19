require 'rails_helper'

RSpec.describe 'Api::V1::Users::ProfilesController', type: :request do
  fixtures(:users)

  describe 'GET /show' do
    before do
      @user = users(:vitalii)
      @token = Api::V1::BaseController.new.encode_token(@user)
    end

    before do
      get api_v1_users_profile_path(format: :json),
          headers: { 'Authorization': "Bearer #{@token}" }
    end

    it 'returns response status' do
      expect(response).to have_http_status(:success)
    end

    it 'returns user data' do
      json = JSON.parse(response.body)
      expect(json['id']).to eq(@user.id)
      expect(json['name']).to eq(@user.name)
      expect(json['email']).to eq(@user.email)
    end
  end
end
