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
      filter = { status_eq: 'approved' }
      filter.merge! params.permit(:make_cont_any, :model_cont_any, :body_type_cont_any,
                                  :color_cont_any, :fuel_type_cont_any, :engine_volume_cont_any,
                                  :year_gt, :mileage_gt, :price_gt,
                                  :year_lt, :mileage_lt, :price_lt)
      filter
    end

    # def find_cars_params
    #   filter = { status_eq: 'approved' }

    #   %i[make model body_type color fuel_type engine_volume].each do |key|
    #     filter[(key.to_s + '_cont_any').to_sym] = params[key] if params[key].present?
    #   end
    #   %i[year mileage price].each do |key|``
    #     filter[(key.to_s + '_eq').to_sym] = params[key] if params[key].present?
    #   end

    #   filter
    # end
  end
end
