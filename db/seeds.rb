if Rails.env.development?
  # Delete all records
  [User, Car].each(&:delete_all)

  # Create users
  puts 'Creating users...'
  10.times do |i|
    User.create!(name: "User ##{i}",
                 phone_number: "+1234567890#{i}",
                 email: "user#{i}@example.com",
                 password: 'password')
  end

  # Create cars
  puts 'Creating cars...'
  100.times do
    Car.create!(make: Faker::Vehicle.make,
                model: Faker::Vehicle.model,
                body_type: Faker::Vehicle.car_type,
                mileage: Faker::Number.between(from: 1, to: 100_000),
                color: Faker::Color.color_name,
                price: Faker::Number.between(from: 999, to: 100_000_000),
                fuel_type: Faker::Vehicle.fuel_type,
                year: Date.new(Faker::Vehicle.year),
                engine_volume: Faker::Vehicle.version,
                status: Faker::Number.between(from: 0, to: 2),
                image: File.open(File.join(Rails.root, 'spec/fixtures/files/black.jpg')),
                user: User.all.sample)
  end
end
