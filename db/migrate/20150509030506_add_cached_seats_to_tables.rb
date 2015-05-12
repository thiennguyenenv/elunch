class AddCachedSeatsToTables < ActiveRecord::Migration
  def change
    add_column :tables, :cached_seats, :text
  end
end
