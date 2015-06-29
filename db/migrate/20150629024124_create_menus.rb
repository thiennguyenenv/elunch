class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :name
      t.string :description
      t.integer :rating

      t.timestamps null: false
    end
  end
end
