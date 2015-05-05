class AddNameDescriptionToTables < ActiveRecord::Migration
  def change
    add_column :tables, :name, :text
    add_column :tables, :description, :text
  end
end
