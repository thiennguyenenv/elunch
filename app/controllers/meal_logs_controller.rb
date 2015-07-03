class MealLogsController < ApplicationController
  layout :determine_layout
  before_action :set_meal_log, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @meal_logs = Kaminari.paginate_array(MealLog.all).page(params[:page])
    respond_with(@meal_logs)
  end

  def show
    respond_with(@meal_log)
  end

  def new
    @shifts = Shift.all
    @meal_log = MealLog.new
    @meals = Meal.all
    @menus = Menu.all
    respond_with(@meal_log)
  end

  def edit
    @shifts = Shift.all
    @meals = Meal.all
    @menus = Menu.all
  end

  def create
    @meal_log = MealLog.new(meal_log_params)
    flash[:notice] = 'MealLog was successfully created.' if @meal_log.save
    respond_with(@meal_log)
  end

  def update
    flash[:notice] = 'MealLog was successfully updated.' if @meal_log.update(meal_log_params)
    respond_with(@meal_log)
  end

  def destroy
    @meal_log.destroy
    respond_with(@meal_log)
  end

  def track_data
    table = Table.find(params[:id])
    if table.present?
      table.cached_seats.each do |seat|
        seat[:status] = 1
      end
      @meal_log = MealLog.where(meal_id: params[:meal], menu_id: params[:menu], table_id: params[:id]).first_or_create(tracking_data: table.cached_seats)
    end
    render partial: 'view_table_with_status', object: @meal_log
  end

  private
  def set_meal_log
    @meal_log = MealLog.find(params[:id])
  end

  def meal_log_params
    params.require(:meal_log).permit(:meal_id, :table_id, :menu_id, :tracking_data, :notes)
  end
end
