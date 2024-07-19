module Api::V1::Ads
  class CarsController < ApplicationController
    before_action :filter_params, only: :index

    def index
      @query = Car.ransack(filter_params)
      @cars = @query.result.includes(:user)
                    .page(params[:page] || 1)
    end

    private

    def filter_params
      filter = { status_eq: 'approved' }

      %i[make model body_type mileage color
         price fuel_type year engine_volume].each do |key|
        filter[(key.to_s + '_cont_any').to_sym] = params[key] if params[key].present?
      end
      filter
    end
  end
end
