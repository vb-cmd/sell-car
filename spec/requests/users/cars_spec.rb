require 'rails_helper'

RSpec.describe 'Users::CarsController', type: :request do
  fixtures(:all)

  before do
    @car = cars(:ford)
    @user = users(:vitalii)
    
    user_login(@user)
  end

  describe 'GET /index' do
    it 'returns http success' do
      get ads_cars_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get edit_users_car_path(@car)
      expect(response).to have_http_status(:success)
    end
  end
end
