class AddNumberSeatsAndAvailableSeatsToSeatingCharts < ActiveRecord::Migration
  def change
    add_column :seating_charts, :number_seats, :integer
    add_column :seating_charts, :available_seats, :integer
  end
end
