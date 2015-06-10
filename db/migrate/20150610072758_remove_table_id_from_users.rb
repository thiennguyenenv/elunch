class RemoveTableIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :table_id
  end
end
