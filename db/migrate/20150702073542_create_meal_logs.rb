class CreateMealLogs < ActiveRecord::Migration
  def change
    create_table :meal_logs do |t|
      t.integer :meal_id
      t.integer :table_id
      t.text :tracking_data

      t.timestamps null: false
    end
  end
end
