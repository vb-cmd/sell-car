module Api::V1::Ads
  class CarsController < ApplicationController
    before_action :cars_params, only: :index

    def index
      @query = Car.ransack(cars_params)
      @cars = @query.result.includes(:user)
                    .page(params[:page] || 1)
    end

    private

    def cars_params
      filter = { status_eq: 2 }
      filter.merge! params.permit(:make_cont_any, :model_cont_any, :body_type_cont_any,
                                  :color_cont_any, :fuel_type_cont_any, :engine_volume_cont_any,
                                  :year_gt, :mileage_gt, :price_gt,
                                  :year_lt, :mileage_lt, :price_lt)
      filter
    end
  end
end
