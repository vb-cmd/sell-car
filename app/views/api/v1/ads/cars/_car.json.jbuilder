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
json.image_url car.image.present? ? url_for(car.image) : ''

json.user do
  json.extract! car.user, :name, :phone_number
end
