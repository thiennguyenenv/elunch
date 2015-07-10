class SeatingChart < ActiveRecord::Base
  belongs_to :table
  belongs_to :seating_chart_category
  serialize :seating_chart
end