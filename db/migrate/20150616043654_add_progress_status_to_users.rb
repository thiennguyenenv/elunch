class AddProgressStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :progress_status, :integer, limit: 1, default: 0b00000000
  end
end
