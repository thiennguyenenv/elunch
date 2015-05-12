class AddTableIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :table_id, :integer
  end
end
