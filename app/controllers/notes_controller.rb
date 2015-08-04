class NotesController < ApplicationController
  layout :determine_layout
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @notes = Note.all
    respond_with(@notes)
  end

  def show
    respond_with(@note)
  end

  def new
    @note = Note.new
    respond_with(@note)
  end

  def edit
  end

  def create
    @note = Note.new(note_params)
    flash[:notice] = 'Note was successfully created.' if @note.save
    respond_with(@note)
  end

  def update
    flash[:notice] = 'Note was successfully updated.' if @note.update(note_params)
    respond_with(@note)
  end

  def destroy
    @note.destroy
    respond_with(@note)
  end

  private
    def set_note
      @note = Note.find(params[:id])
    end

    def note_params
      params.require(:note).permit(:name, :description, :group_id, :reset_option)
    end
end
