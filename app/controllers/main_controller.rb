class MainController < ApplicationController
  layout :determine_layout
  def index
    @two_days = Meal.where('meal_date >= ? AND meal_date <= ?', Date.today.beginning_of_day, Date.tomorrow.end_of_day)
  end
end
