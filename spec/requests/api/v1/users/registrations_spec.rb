require 'rails_helper'

RSpec.describe 'Api::V1::Users::RegistrationsController', type: :request do
  describe 'POST /api/v1/users/registration' do
    it 'creates a new user' do
      post api_v1_users_registration_path(format: :json),
          params: {
            user: {
              name: 'testuser',
              email: 'user@example.com',
              password: 'password',
              password_confirmation: 'password',
              phone_number: '+1234567890'
            }
          }

      expect(response).to have_http_status(:success)
    end

    it 'does not create a new user with invalid params' do
      post api_v1_users_registration_path(format: :json),
           params: {
             user: {
               name: '',
               email: 'user@example.com',
               phone_number: '+1234567890'
             }
           }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
