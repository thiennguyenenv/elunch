class AddMenuIdToMeals < ActiveRecord::Migration
  def change
    add_column :meals, :menu_id, :integer
  end
end
