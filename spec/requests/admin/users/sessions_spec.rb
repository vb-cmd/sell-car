require 'rails_helper'

RSpec.describe 'Admin::Users::SessionsController', type: :request do
  fixtures :admin_users

  before do
    @admin_user = admin_users(:admin)
  end

  describe 'GET show' do
    it 'returns http success' do
      get admin_users_session_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST create' do
    it 'returns http success login' do
      admin_user_login(@admin_user.email, 'password')

      expect(response).to have_http_status(:success)
      expect(response.body).to include('Logged in!')
    end

    it 'returns http incorrect login' do
      admin_user_login('noadmin@admin.com', 'nopassword')

      expect(response).to have_http_status(:success)
      expect(response.body).to include('Invalid email or password')
      expect(request.env['PATH_INFO']).to include(admin_users_session_path)
    end
  end

  describe 'DELETE destroy' do
    it 'returns http success logout' do
      delete admin_users_session_path

      expect(response).to have_http_status(:redirect)

      follow_redirect!

      expect(response).to have_http_status(:success)
      expect(request.env['PATH_INFO']).to include(admin_users_session_path)
      expect(response.body).to include('Logged out!')
    end
  end
end
