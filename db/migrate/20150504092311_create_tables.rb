class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.integer :seats
      t.integer :shift_id
      t.integer :available_seats
      t.hstore  :cached_users
      t.timestamps null: false
    end
  end
end
