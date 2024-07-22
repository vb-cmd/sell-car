module Admin::BaseHelper
  def logged_in?
    !!session[:admin_user_id]
  end

  def current_admin_user
    @current_admin_user ||= AdminUser.find(session[:admin_user_id]) if logged_in?
  end
end
