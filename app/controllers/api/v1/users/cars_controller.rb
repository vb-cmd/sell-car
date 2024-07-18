module Api::V1::Users
  class CarsController < Api::V1::BaseController
    def index
      @cars = current_user.cars
    end

    def show
      @car = current_user.cars.find(params[:id])
    end

    def create
      @car = current_user.cars.create!(car_params)
    end

    def update
      @car = current_user.cars.find(params[:id])
      @car.update(car_params)
    end

    def destroy
      @car = current_user.cars.find(params[:id])
      @car.destroy
    end

    private

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
