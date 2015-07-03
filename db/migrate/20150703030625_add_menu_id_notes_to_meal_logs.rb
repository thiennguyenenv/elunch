class AddMenuIdNotesToMealLogs < ActiveRecord::Migration
  def change
    add_column :meal_logs, :menu_id, :integer
    add_column :meal_logs, :notes, :string
  end
end
