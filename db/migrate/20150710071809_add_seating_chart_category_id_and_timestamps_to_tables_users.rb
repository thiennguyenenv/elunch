class AddSeatingChartCategoryIdAndTimestampsToTablesUsers < ActiveRecord::Migration
  def change
    add_column :tables_users, :seating_chart_cat_id, :integer
    add_column :tables_users, :created_at, :datetime
    add_column :tables_users, :updated_at, :datetime
  end
end
