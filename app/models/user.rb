class User < ApplicationRecord
  has_secure_password
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true

  has_many :cars
end
