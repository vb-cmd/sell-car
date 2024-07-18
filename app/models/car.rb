class Car < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :make, :model, :body_type, :mileage, :color, :price, :fuel_type, :year, :engine_volume, presence: true
  enum status: %i[pending rejected approved]
end
