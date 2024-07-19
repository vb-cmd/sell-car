require 'rails_helper'

RSpec.describe 'Api::V1::Users::CarsController', type: :request do
  fixtures :all

  before do
    @car = cars(:ford)
    @user = @car.user
    @token = Api::V1::BaseController.new.encode_token(@user)
  end

  describe 'GET /api/v1/users/cars' do
    before do
      get api_v1_users_cars_path(format: :json),
          headers: { 'Authorization': "Bearer #{@token}" }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the cars' do
      json = JSON.parse(response.body)

      expect(json.length).to eq(1)
    end
  end

  describe 'GET /api/v1/users/cars/:id' do
    before do
      get api_v1_users_car_path(@user.cars.first, format: :json),
          headers: { 'Authorization': "Bearer #{@token}" }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the car' do
      first = JSON.parse(response.body)

      expect(first['id']).to eq(@car.id)
      expect(first['make']).to eq(@car.make)
      expect(first['model']).to eq(@car.model)
      expect(first['body_type']).to eq(@car.body_type)
      expect(first['mileage']).to eq(@car.mileage)
      expect(first['color']).to eq(@car.color)
      expect(first['price'].to_f).to eq(@car.price)
      expect(first['fuel_type']).to eq(@car.fuel_type)
      expect(Date.parse(first['year'])).to eq(@car.year)
      expect(first['engine_volume']).to eq(@car.engine_volume)
      expect(first['status']).to eq(@car.status)
    end
  end

  describe 'POST /api/v1/users/cars' do
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
               year: '2023-01-01',
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

  describe 'PUT /api/v1/users/cars' do
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

  describe 'DELETE /api/v1/users/cars' do
    it 'deletes a car' do
      delete api_v1_users_car_path(@car, format: :json),
             headers: { 'Authorization': "Bearer #{@token}" }

      expect(response).to have_http_status(:success)
      expect(Car.count).to eq(0)
    end
  end
end
