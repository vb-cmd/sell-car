require 'rails_helper'

RSpec.describe 'Admin::Dashboards::CarsController', type: :request do
  fixtures :all

  before do
    @admin_user = admin_users(:admin)
    @user = users(:vitalii)
    @car = cars(:ford)

    admin_user_login(@admin_user.email, 'password')
  end

  describe 'GET /index' do
    it 'returns http success' do
      get admin_dashboards_cars_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get admin_dashboards_car_path(@car)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_admin_dashboards_car_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'returns a new car' do
      post admin_dashboards_cars_path, params: {
        car: {
          make: 'text make',
          model: 'test model',
          body_type: 'test body_type',
          mileage: 10,
          color: 'test color',
          price: 10_000,
          fuel_type: 'test fuel_type',
          year: 2000,
          engine_volume: 'test engine_volume',
          image: fixture_file_upload('black.jpg', 'image/jpg'),
          status: 'rejected',
          user_id: @user.id
        }
      }

      expect(response).to have_http_status(:redirect)

      follow_redirect!

      last_car = Car.last

      expect(Car.count).to eq(2)
      expect(last_car.user.id).to eq(@user.id)
      expect(last_car.status).to eq('rejected')

      expect(request.env['PATH_INFO']).to eq(admin_dashboards_car_path(last_car))
      expect(response.body).to include('Car was successfully created.')
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get edit_admin_dashboards_car_path(@car)

      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    it 'returns http success' do
      patch admin_dashboards_car_path(@car), params: {
        car: {
          make: 'text make',
          model: 'test model',
          body_type: 'test body_type',
          mileage: 10,
          color: 'test color',
          price: 10_000,
          fuel_type: 'test fuel_type',
          year: 2000,
          engine_volume: 'test engine_volume',
          image: fixture_file_upload('black.jpg', 'image/jpg'),
          status: 'approved',
          user_id: @user.id
        }
      }

      expect(response).to have_http_status(:redirect)

      follow_redirect!

      expect(request.env['PATH_INFO']).to eq(admin_dashboards_car_path(@car))
      expect(response.body).to include('Car was successfully updated.')

      updated_car = Car.find(@car.id)

      expect(updated_car.user.id).to eq(@car.user.id)
      expect(updated_car.make).not_to eq(@car.make)
      expect(updated_car.year).not_to eq(@car.year)
      expect(updated_car.status).not_to eq(@car.status)
    end
  end

  describe 'DELETE /destroy' do
    it 'deletes a car' do
      delete admin_dashboards_car_path(@car)

      expect(response).to have_http_status(:redirect)

      follow_redirect!

      expect(request.env['PATH_INFO']).to include(admin_dashboards_cars_path)
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Car was successfully deleted.')
    end
  end
end
