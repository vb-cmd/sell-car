class CreateCars < ActiveRecord::Migration[7.1]
  def change
    create_table :cars do |t|
      t.string :make
      t.string :model
      t.string :body_type
      t.integer :mileage
      t.string :color
      t.decimal :price
      t.string :fuel_type
      t.date :year
      t.string :engine_volume
      t.integer :status, default: 0
      t.belongs_to :user

      t.timestamps
    end
  end
end
