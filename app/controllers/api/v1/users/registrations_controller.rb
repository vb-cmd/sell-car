module Api::V1::Users
  class RegistrationsController < Api::V1::BaseController
    skip_before_action :authorized, only: [:create]
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

    def create
      @user = User.create!(user_params)
      @token = encode_token(@user)
    end

    private

    def render_unprocessable_entity(invalid)
      render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def user_params
      params.require(:user)
            .permit(:email,
                    :password,
                    :password_confirmation,
                    :name,
                    :phone_number)
    end
  end
end
