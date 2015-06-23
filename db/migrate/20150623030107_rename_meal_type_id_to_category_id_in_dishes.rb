class RenameMealTypeIdToCategoryIdInDishes < ActiveRecord::Migration
  def change
    rename_column :dishes, :meal_type_id, :category_id
  end
end
