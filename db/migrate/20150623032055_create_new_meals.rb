class CreateNewMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.datetime :meal_date
      t.integer :preordered_meals
      t.integer :actual_meals
      t.integer :extra_meals
      t.integer :absence_with_notice
    end
  end
end
