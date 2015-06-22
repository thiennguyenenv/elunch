class MealsController < ApplicationController
  layout :determine_layout
  before_action :set_meal, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @meals = Kaminari.paginate_array(Meal.all).page(params[:page])
    respond_with(@meals)
  end

  def show
    @pictures = @meal.pictures
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
    if @meal.save
      if params[:images]
        params[:images].each do |image|
          @meal.pictures.create(image: image)
        end
      end
    end
    respond_with(@meal)
  end

  def update
    if @meal.update(meal_params)
      if params[:images]
        params[:images].each do |image|
          @meal.pictures.create(image: image)
        end
      end
    end

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
      params.require(:meal).permit(:name, :description, :rating, :meal_type_id, :pictures)
    end
end
