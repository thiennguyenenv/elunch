class CreateDishesMenus < ActiveRecord::Migration
  def change
    create_table :dishes_menus do |t|
      t.integer :dish_id
      t.integer :menu_id
    end
  end
end
