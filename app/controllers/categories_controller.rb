class CategoriesController < ApplicationController
  layout :determine_layout
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @categories = Kaminari.paginate_array(Category.all).page(params[:page])
    respond_with(@categories)
  end

  def show
    respond_with(@category)
  end

  def new
    @category = Category.new
    respond_with(@category)
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    flash[:notice] = 'Category was successfully created.' if @category.save
    respond_with(@category)
  end

  def update
    flash[:notice] = 'Category was successfully updated.' if @category.update(category_params)
    respond_with(@category)
  end

  def destroy
    @category.destroy
    respond_with(@category)
  end

  def list_dishes
    @dishes =  Dish.where(category_id: params[:id])
    render partial: 'list_dishes'
  end

  private
  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params[:category].permit(:name, :description)
  end
end
