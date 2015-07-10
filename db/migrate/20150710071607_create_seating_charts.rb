class CreateSeatingCharts < ActiveRecord::Migration
  def change
    create_table :seating_charts do |t|
      t.string :description
      t.integer :table_id
      t.integer :chart_category_id
      t.string :seating_chart

      t.timestamps null: false
    end
  end
end
