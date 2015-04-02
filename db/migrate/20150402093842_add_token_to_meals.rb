class AddTokenToMeals < ActiveRecord::Migration
  def change
    add_column :meals, :token, :string
  end
end
