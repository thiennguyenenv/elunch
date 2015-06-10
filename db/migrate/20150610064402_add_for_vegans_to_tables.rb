class AddForVegansToTables < ActiveRecord::Migration
  def change
    add_column :tables, :for_vegans, :boolean, default: false
  end
end
