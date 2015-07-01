class MealsController < ApplicationController
  layout :determine_layout
  before_action :set_meal, only: [:show, :edit, :update, :destroy, :select_menu]

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
    @menus = Menu.all
    respond_with(@meal)
  end

  def edit
    @menus = Menu.all
  end

  def create
    new_meal = meal_params
    @meal = Meal.new(new_meal)
    respond_with(@meal) do |format|
      if @meal.save
        @menus = Menu.all
        flash.now[:notice] = 'Meal was successfully created.'
        format.html { render action: :edit }
      else
        format.html { render action: :new }
      end
    end
  end

  def update
    update_meal = meal_params
    @meal.update(update_meal)
    respond_with(@meal)
  end

  def destroy
    @meal.destroy
    respond_with(@meal)
  end

  def select_menu
    @menu = Menu.find(params[:menu_id])
    if @menu.present?
      @meal.menu_id = @menu.id
      @meal.save
      render partial: 'list_meal_items'
    end
  end

  private
  def set_meal
    @meal = Meal.find(params[:id])
  end

  def meal_params
    params.require(:meal).permit(:meal_date, :preordered_meals, :actual_meals, :extra_meals, :absence_with_notice, :menu_id)
  end
end
