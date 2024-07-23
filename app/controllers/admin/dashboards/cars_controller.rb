class Admin::Dashboards::CarsController < Admin::BaseController
  before_action :set_car, only: %i[show edit update destroy]

  def index
    @cars = if params[:status].present?
              Car.where(status: params[:status])
                 .page(params[:page] || 1)
            else
              Car.page(params[:page] || 1)
            end
  end

  def show; end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)

    if @car.save
      redirect_to admin_dashboards_car_path(@car),
                  notice: 'Car was successfully created.'
    else
      redirect_to new_admin_dashboards_car_path,
                  alert: @car.errors.full_messages
    end
  end

  def edit; end

  def update
    if @car.update(car_params)
      redirect_to admin_dashboards_car_path(@car),
                  notice: 'Car was successfully updated.'
    else
      redirect_to edit_admin_dashboards_car_path(@car),
                  alert: @car.errors.full_messages
    end
  end

  def destroy
    @car.destroy
    redirect_to admin_dashboards_cars_path,
                notice: 'Car was successfully deleted.'
  end

  private

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car)
          .permit(:make, :model, :body_type, :mileage, :color, :price, :fuel_type, :year, :engine_volume,
                  :image, :status, :user_id)
  end
end
