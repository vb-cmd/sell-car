require 'rails_helper'

RSpec.describe 'Users::ProfilesController', type: :request do
  fixtures(:users)

  before do
    @user = users(:vitalii)
    user_login(@user)
  end

  describe 'GET /show' do
    it 'returns http success' do
      get users_profile_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get edit_users_profile_path
      expect(response).to have_http_status(:success)
    end
  end
end
