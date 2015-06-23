class DishesController < ApplicationController
  layout :determine_layout
  before_action :set_dish, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @dishes = Kaminari.paginate_array(Dish.all).page(params[:page])
    respond_with(@dishes)
  end

  def show
    @pictures = @dish.pictures
    respond_with(@dish)
  end

  def new
    @dish = Dish.new
    respond_with(@dish)
  end

  def edit
  end

  def create
    @dish = Dish.new(dish_params)
    binding.pry
    if @dish.save
      if params[:images]
        params[:images].each do |image|
          @dish.pictures.create(image: image)
        end
      end
    end
    respond_with(@dish)
  end

  def update
    if @dish.update(dish_params)
      if params[:images]
        params[:images].each do |image|
          @dish.pictures.create(image: image)
        end
      end
    end

    respond_with(@dish)
  end

  def destroy
    @dish.destroy
    respond_with(@dish)
  end

  private
  def set_dish
    @dish = Dish.find(params[:id])
  end

  def dish_params
    params.require(:dish).permit(:name, :description, :rating, :category_id, :pictures)
  end
end
