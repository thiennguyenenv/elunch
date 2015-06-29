class MealsController < ApplicationController
  layout :determine_layout
  before_action :set_meal, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @meals = Kaminari.paginate_array(Meal.all).page(params[:page])
    respond_with(@meals)
  end

  def show
    respond_with(@meal)
  end

  def new
    @meal = Meal.new
    @categories = Category.all
    respond_with(@meal)
  end

  def edit
    @categories = Category.all
  end

  def create
    new_meal = meal_params
    new_meal[:meal_date] = DateTime.strptime(new_meal[:meal_date], '%m/%d/%Y')
    @meal = Meal.new(new_meal)
    @meal.save
    respond_with(@meal)
  end

  def update
    update_meal = meal_params
    update_meal[:meal_date] = DateTime.strptime(new_meal[:meal_date], '%m/%d/%Y')
    @meal.update(update_meal)
    respond_with(@meal)
  end

  def destroy
    @meal.destroy
    respond_with(@meal)
  end

  private
  def set_meal
    @meal = Meal.find(params[:id])
  end

  def meal_params
    params.require(:meal).permit(:meal_date, :preordered_meals, :actual_meals, :extra_meals, :absence_with_notice)
  end
end
