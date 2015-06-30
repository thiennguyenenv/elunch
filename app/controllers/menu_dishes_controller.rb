class MenuDishesController < ApplicationController
  def index
  end

  def create
    @menu = Menu.find(params[:menu_id])
    @dish = Dish.find(params[:dish_id])
    if @menu.present? and @dish.present?
      DishesMenu.create({ dish_id: @dish.id, menu_id: @menu.id })
      render partial: '/dishes/list_menu_dishes'
    end
  end

  def destroy
    @menu = Menu.find(params[:menu_id])
    @dish = Dish.find(params[:id])
    if @menu.present? and @dish.present?
      DishesMenu.where(dish_id: @dish.id, menu_id: @menu.id).destroy_all
      render partial: '/dishes/list_menu_dishes'
    end
  end
end
