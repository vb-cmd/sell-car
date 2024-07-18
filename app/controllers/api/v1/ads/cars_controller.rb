module Api::V1::Ads
  class CarsController < ApplicationController
    def index
      @cars = Car.all.includes(:user)
    end
  end
end