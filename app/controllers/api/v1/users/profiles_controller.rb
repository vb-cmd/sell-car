module Api::V1::Users
  class ProfilesController < Api::V1::BaseController
    def show
      @user = current_user
    end
  end
end
