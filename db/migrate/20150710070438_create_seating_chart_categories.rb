class CreateSeatingChartCategories < ActiveRecord::Migration
  def change
    create_table :seating_chart_categories do |t|
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
