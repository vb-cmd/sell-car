module Api::V1::Users
  class ProfilesController < Api::V1::BaseController
    def show
      @user = current_user
    end

    def update
      current_user.update!(user_params)
    end

    private

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
