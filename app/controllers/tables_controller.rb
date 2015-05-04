class TablesController < ApplicationController
  before_action :set_table, only: [:show, :edit, :update, :destroy]

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
    respond_with(@table)
  end

  def edit
  end

  def create
    @table = Table.new(table_params)
    @table.save
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

  private
    def set_table
      @table = Table.find(params[:id])
    end

    def table_params
      params.require(:table).permit(:seats, :shift_id, :available_seats)
    end
end
