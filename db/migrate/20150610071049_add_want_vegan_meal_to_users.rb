class AddWantVeganMealToUsers < ActiveRecord::Migration
  def change
    add_column :users, :want_vegan_meal, :boolean, default: false
  end
end
