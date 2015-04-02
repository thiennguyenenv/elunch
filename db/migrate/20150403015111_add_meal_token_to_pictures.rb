class AddMealTokenToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :meal_token, :string
  end
end
