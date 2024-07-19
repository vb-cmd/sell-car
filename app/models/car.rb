class Car < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :make, :model, :body_type, :mileage, :color, :price, :fuel_type, :year, :engine_volume, presence: true

  enum status: %i[pending rejected approved]

  paginates_per(10)

  def self.ransackable_attributes(_auth_object = nil)
    %w[body_type color created_at engine_volume fuel_type id id_value make mileage model
       price status updated_at year]
  end
end
