class CreateDishesMeals < ActiveRecord::Migration
  def change
    create_table :dishes_meals do |t|
      t.integer :dish_id
      t.integer :meal_id
    end
  end
end
