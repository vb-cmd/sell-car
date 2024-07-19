module Api::V1
  class BaseController < ApplicationController
    before_action :authorized
    skip_before_action :verify_authenticity_token

    def encode_token(user)
      JWT.encode({ user_id: user.id }, ENV['JWT_KEY'])
    end

    def decoded_token
      header = request.headers['Authorization']
      return unless header

      token = header.split(' ')[1]
      begin
        JWT.decode(token, ENV['JWT_KEY'])
      rescue JWT::DecodeError
        nil
      end
    end

    def current_user
      return unless decoded_token

      user_id = decoded_token[0]['user_id']
      @user = User.find(user_id)
    end

    def authorized
      return if !!current_user

      render json: { message: 'Please log in' }, status: :unauthorized
    end
  end
end
