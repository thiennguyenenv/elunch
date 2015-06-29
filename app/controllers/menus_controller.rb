class MenusController < ApplicationController
  before_action :set_menu, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @menus = Menu.all
    respond_with(@menus)
  end

  def show
    respond_with(@menu)
  end

  def new
    @menu = Menu.new
    respond_with(@menu)
  end

  def edit
  end

  def create
    @menu = Menu.new(menu_params)
    flash[:notice] = 'Menu was successfully created.' if @menu.save
    respond_with(@menu)
  end

  def update
    flash[:notice] = 'Menu was successfully updated.' if @menu.update(menu_params)
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
      params.require(:menu).permit(:name, :description, :rating)
    end
end
