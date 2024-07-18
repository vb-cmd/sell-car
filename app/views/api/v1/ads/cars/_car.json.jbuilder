json.extract! car,
              :make,
              :model,
              :body_type,
              :mileage,
              :color,
              :price,
              :fuel_type,
              :year,
              :engine_volume
json.url car_path(car)
json.image_url car.image.url

json.user do
  json.extract! car.user, :name, :phone_number
end
