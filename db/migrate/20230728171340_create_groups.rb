class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.integer :week, null: false
      t.references :restaurant, null: true, foreign_key: { to_table: :restaurants }

      t.timestamps
    end
  end
end
