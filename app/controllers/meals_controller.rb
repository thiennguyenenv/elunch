class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @meals = Meal.all
    respond_with(@meals)
  end

  def show
    respond_with(@meal)
  end

  def new
    @meal = Meal.new
    respond_with(@meal)
  end

  def edit
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.save
    respond_with(@meal)
  end

  def update
    @meal.update(meal_params)
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
      params.require(:meal).permit(:name, :description, :rating, :meal_type_id)
    end
end
