class Car < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :make, :model, :body_type, :mileage, :color, :price, :fuel_type, :year, :engine_volume, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 1900,
                                   less_than_or_equal_to: 2100 }
  validates :mileage, :price, numericality: { greater_than_or_equal_to: 0 }

  enum status: %i[pending rejected approved]

  paginates_per(10)

  def self.ransackable_attributes(auth_object = nil)
    %w[body_type color engine_volume fuel_type make mileage model price year status user_id]
  end
end
