class TablesController < ApplicationController
  layout :determine_layout
  before_action :set_table, only: [:show, :edit, :update, :destroy, :view_table]

  respond_to :html

  def index
    @tables = Kaminari.paginate_array(Table.all).page(params[:page])
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
    if @table.save && @table.init_seats(params[:table][:seats])
      respond_with(@table)
    end
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

  def list_table_names
    @tables = Table.where(shift_id: params[:shift_id]).select(:id, :name)
    render partial: 'list_table_names', object: @tables
  end

  private
  def set_table
    @table = Table.find(params[:id])
  end

  def table_params
    params.require(:table).permit(:name, :description, :shift_id, :for_vegans)
  end
end
