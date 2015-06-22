class TablesController < ApplicationController
  layout :determine_layout
  before_action :set_table, only: [:show, :edit, :update, :destroy, :view_table]

  respond_to :html

  def index
    @tables = Table.all
    respond_with(@tables)
  end

  def show
    respond_with(@table)
  end

  def new
    @table = Table.new
    @table.shifts = Shift.all
    respond_with(@table)
  end

  def edit
    @table.shifts = Shift.all
  end

  def create
    @table = Table.new(table_params)
    if @table.init_seats
      @table.save
    end
        
    respond_with(@table)
  end

  def update
    @table.update(table_params)
    respond_with(@table)
  end

  def destroy
    @table.destroy
    respond_with(@table)
  end

  def view_table
    render partial: 'view_table', object: @table
  end

  def list_tables
    @tables = Table.where(shift_id: params[:shift_id], for_vegans: false)
    render partial: 'list_tables', object: @tables
  end

  def list_vegan_tables
    @tables = Table.where(shift_id: params[:shift_id], for_vegans: true)
    render partial: 'list_tables', object: @tables
  end

  private
    def set_table
      @table = Table.find(params[:id])
    end

    def table_params
      params.require(:table).permit(:name, :description, :seats, :shift_id, :available_seats, :for_vegans)
    end
end
