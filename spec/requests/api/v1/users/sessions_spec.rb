require 'rails_helper'

RSpec.describe 'Api::V1::Users::SessionsController', type: :request do
  fixtures(:users)

  describe 'POST /api/v1/users/sessions' do
    before do
      @user = users(:vitalii)
    end

    it 'is entering the correct password' do
      post api_v1_users_session_path(format: :json),
           params: { user: { email: @user.email, password: 'password' } }
      expect(response).to have_http_status(:success)
    end

    it 'is entering the wrong password' do
      post api_v1_users_session_path(format: :json),
           params: { user: { email: @user.email, password: 'aaaaaaaa' } }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
