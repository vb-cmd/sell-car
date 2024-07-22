class Admin::Users::SessionsController < Admin::BaseController
  skip_before_action :check_authorized_admin_user

  def show; end

  def create
    @admin_user = AdminUser.find_by(email: user_params[:email])

    if !!@admin_user && @admin_user.authenticate(user_params[:password])
      session[:admin_user_id] = @admin_user.id
      redirect_to admin_dashboards_cars_path, notice: 'Logged in!'
    else
      redirect_to admin_users_session_path, alert: 'Invalid email or password'
    end
  end

  def destroy
    session[:admin_user_id] = nil

    redirect_to admin_users_session_path, notice: 'Logged out!'
  end

  private

  def user_params
    params.require(:admin_user).permit(:email, :password)
  end
end
