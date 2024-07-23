require 'rails_helper'

RSpec.describe 'Admin::Dashboards::HomeController', type: :request do
  fixtures :admin_users

  before do
    @admin_user = admin_users(:admin)
  end

  describe 'GET admin' do
    it 'returns http success' do
      admin_user_login(@admin_user.email, 'password')

      get admin_home_path

      expect(response).to have_http_status(:success)
      expect(request.env['PATH_INFO']).to include(admin_home_path)
    end
  end
end
