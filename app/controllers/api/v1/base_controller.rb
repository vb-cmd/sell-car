module Api::V1
  class BaseController < ApplicationController
    before_action :authorized_render_json
    skip_before_action :verify_authenticity_token
  end
end