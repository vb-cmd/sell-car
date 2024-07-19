module Api::V1
  class BaseController < ApplicationController
    before_action :authorized
    skip_before_action :verify_authenticity_token
  end
end