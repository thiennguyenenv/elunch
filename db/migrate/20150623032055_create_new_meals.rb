class CreateNewMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.datetime :meal_date
      t.integer :preordered_meals, default: 0
      t.integer :actual_meals, default: 0
      t.integer :extra_meals, default: 0
      t.integer :absence_with_notice, default: 0
      t.timestamps null: false
    end
  end
end
