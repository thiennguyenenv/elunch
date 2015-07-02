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
    respond_with(@meal_log)
  end

  def edit
    @shifts = Shift.all
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

  private
  def set_meal_log
    @meal_log = MealLog.find(params[:id])
  end

  def meal_log_params
    params.require(:meal_log).permit(:meal_id, :table_id, :tracking_data)
  end
end
