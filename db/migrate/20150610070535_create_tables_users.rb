class CreateTablesUsers < ActiveRecord::Migration
  def change
    create_table :tables_users, id: false do |t|
      t.column 'table_id', :integer
      t.column 'user_id', :integer
    end
  end
end
