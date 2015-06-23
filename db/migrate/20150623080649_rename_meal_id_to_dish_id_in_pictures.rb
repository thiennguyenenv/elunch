class RenameMealIdToDishIdInPictures < ActiveRecord::Migration
  def change
    rename_column :pictures, :meal_id, :dish_id
  end
end
