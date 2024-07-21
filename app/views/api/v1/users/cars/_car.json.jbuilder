json.extract! car,
              :id,
              :make,
              :model,
              :body_type,
              :mileage,
              :color,
              :price,
              :fuel_type,
              :year,
              :engine_volume,
              :status
json.edit_url edit_users_car_path(car)
json.image_url url_for(car.image)
