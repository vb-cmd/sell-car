module Api::V1::Users
  class RegistrationsController < Api::V1::BaseController
    skip_before_action :authorized, only: [:create]

    def create
      @user = User.create!(user_params)
      @token = encode_token({ user_id: @user.id })
    end

    private 

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :phone_number)
    end
  end
end