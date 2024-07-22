class Admin::BaseController < ApplicationController
  before_action :check_authorized_admin_user
  layout 'layouts/admin_application'

  def logged_in?
    !!session[:admin_user_id]
  end

  def current_admin_user
    @current_admin_user ||= AdminUser.find(session[:admin_user_id]) if logged_in?
  end

  def check_authorized_admin_user
    return if logged_in?

    redirect_to admin_users_session_path,
                alert: 'Please log in'
  end
end
