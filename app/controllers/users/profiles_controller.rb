class Users::ProfilesController < ApplicationController
  before_action :authorized, only: %i[show]
  
  def show; end
end
