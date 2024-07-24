require 'rails_helper'

RSpec.describe 'Api::V1::Users::CarsController', type: :request do
  fixtures :all

  before do
    @car = cars(:ford)
    @user = @car.user
    @token = Api::V1::BaseController.new.encode_token(@user)
  end

  describe 'GET /index' do
    before do
      get api_v1_users_cars_path(format: :json),
          headers: { 'Authorization': "Bearer #{@token}" }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the cars' do
      json = JSON.parse(response.body)

      expect(json.length).to eq(@user.cars.count)
    end
  end

  describe 'GET /show' do
    before do
      get api_v1_users_car_path(@user.cars.first, format: :json),
          headers: { 'Authorization': "Bearer #{@token}" }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the car' do
      first = JSON.parse(response.body)
      first_car_user = @user.cars.first
      
      expect(first['id']).to eq(first_car_user.id)
    end
  end

  describe 'POST /create' do
    it 'creates a new car' do
      post api_v1_users_cars_path(format: :json),
           headers: { 'Authorization': "Bearer #{@token}" },
           params: {
             car: {
               make: 'ford',
               model: 'mustang',
               body_type: 'sedan',
               mileage: 2000,
               color: 'black',
               price: 20_000,
               fuel_type: 'diesel',
               year: 2023,
               engine_volume: '2.0',
               image: fixture_file_upload('black.jpg', 'image/jpg')
             }
           }

      expect(response).to have_http_status(:success)
    end

    it 'does not create a new car with invalid params' do
      post api_v1_users_cars_path(format: :json),
           headers: { 'Authorization': "Bearer #{@token}" },
           params: {
             car: {
               make: ''
             }
           }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PUT /update' do
    it 'updates a car' do
      put api_v1_users_car_path(@car, format: :json),
          headers: { 'Authorization': "Bearer #{@token}" },
          params: {
            car: {
              color: 'white'
            }
          }

      expect(response).to have_http_status(:success)
      expect(@car.reload.color).to eq('white')
    end
  end

  describe 'DELETE /destroy' do
    it 'deletes a car' do
      cached_car_count = Car.count
      delete api_v1_users_car_path(@car, format: :json),
             headers: { 'Authorization': "Bearer #{@token}" }

      expect(response).to have_http_status(:success)
      expect(Car.count).to eq(cached_car_count - 1)
    end
  end
end
