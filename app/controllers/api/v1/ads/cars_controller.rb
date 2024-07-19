module Api::V1::Ads
  class CarsController < ApplicationController
    before_action :set_page, only: :index

    def index
      @cars = Car.includes(:user)
                 .where(status: 'approved')
                 .page(@page)
    end

    private

    def set_page
      @page = params[:page] || 1
    end
  end
end
