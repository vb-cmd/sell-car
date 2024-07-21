class Users::BaseController < ApplicationController
  before_action :authorized_redirect
end