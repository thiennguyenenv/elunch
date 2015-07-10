class SeatingChartCategoriesController < ApplicationController
  layout :determine_layout
  before_action :set_chart_category, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @chart_categories = Kaminari.paginate_array(SeatingChartCategory.all).page(params[:page])
    respond_with(@chart_categories)
  end

  def show
    respond_with(@chart_category)
  end

  def new
    @chart_category = SeatingChartCategory.new
    respond_with(@chart_category)
  end

  def edit
  end

  def create
    @chart_category = SeatingChartCategory.new(seating_chart_params)
    @chart_category.save
    respond_with(@chart_category)
  end

  def update
    @chart_category.update(seating_chart_params)
    respond_with(@chart_category)
  end

  def destroy
    @chart_category.destroy
    respond_with(@chart_category)
  end

  private
  def set_chart_category
    @chart_category = SeatingChartCategory.find(params[:id])
  end

  def seating_chart_params
    params.require(:seating_chart_category).permit(:name, :description)
  end
end
