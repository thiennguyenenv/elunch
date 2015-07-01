class MenusController < ApplicationController
  layout :determine_layout
  before_action :set_menu, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @menus = Kaminari.paginate_array(Menu.all).page(params[:page])
    respond_with(@menus)
  end

  def show
    respond_with(@menu)
  end

  def new
    @meal = Meal.find(params[:meal_id]) if params[:meal_id].present?
    @menu = Menu.new
    @categories = Category.all
    respond_with(@menu)
  end

  def edit
    @meal = Meal.find(params[:meal_id]) if params[:meal_id].present?
    @categories = Category.all
  end

  def create
    meal = Meal.find(params[:meal_id]) if params[:meal_id].present?
    @menu = Menu.new(menu_params)
    @categories = Category.all
    if @menu.save
      if meal.present?
        meal.menu_id = @menu.id
        meal.save
      end
      flash.now[:notice] = 'Menu was successfully created.'
    end
    respond_with(@menu) do |format|
      format.html { render action: :edit }
    end
  end

  def update
    meal = Meal.find(params[:meal_id]) if params[:meal_id].present?
    if @menu.update(menu_params)
      if meal.present?
        meal.menu_id = @menu.id
        meal.save
      end
      flash[:notice] = 'Menu was successfully updated.'
    end
    respond_with(@menu)
  end

  def destroy
    @menu.destroy
    respond_with(@menu)
  end

  private
    def set_menu
      @menu = Menu.find(params[:id])
    end

    def menu_params
      params.require(:menu).permit(:name, :description, :rating, :meal_id)
    end
end
