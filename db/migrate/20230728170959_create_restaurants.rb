class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false, index: { unique: true }
      t.text :address
      t.string :phone_number

      t.timestamps
    end
  end
end
