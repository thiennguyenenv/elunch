class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :name
      t.string :description
      t.decimal :rating
      t.integer :meal_type_id

      t.timestamps null: false
    end
  end
end
