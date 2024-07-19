module Api::V1::Users
  class CarsController < Api::V1::BaseController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

    before_action :find_car, only: %i[show update destroy]

    def index
      @cars = current_user.cars
    end

    def show; end

    def create
      @car = current_user.cars.create!(car_params)
    end

    def update
      @car.update!(car_params)
    end

    def destroy
      @car.destroy!
    end

    private

    def find_car
      @car = current_user.cars.find(params[:id])
    end

    def render_unprocessable_entity(invalid)
      render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def render_not_found
      render json: { errors: 'Car not found' }, status: :not_found
    end

    def car_params
      params.require(:car).permit(:make,
                                  :model,
                                  :body_type,
                                  :mileage,
                                  :color,
                                  :price,
                                  :fuel_type,
                                  :year,
                                  :engine_volume,
                                  :image)
    end
  end
end
