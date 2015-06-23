class RenameMealsToDishes < ActiveRecord::Migration
  def change
    rename_table :meals, :dishes
  end
end
