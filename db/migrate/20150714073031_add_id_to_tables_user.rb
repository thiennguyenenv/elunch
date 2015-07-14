class AddIdToTablesUser < ActiveRecord::Migration
  def change
    add_column :tables_users, :id, :primary_key
  end
end
