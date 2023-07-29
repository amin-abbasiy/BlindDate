class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :email, null: false, index: { unique: true }
      t.string :password, null: false
      t.integer :position
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
  end
end
