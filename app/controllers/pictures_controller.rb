class PicturesController < ApplicationController
  def index
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.create(picture_params)
    if @picture.save
      render json: { message: 'success', fileID: @picture.id}, status: 200
    else
      render json: { error: @picture.errors.full_messages.join(',') }, status: 400
    end
  end

  def destroy
    @picture = Picture.find(params[:id])
    if @picture.destroy
      render json: { message: "File deleted from server" }
    else
      render json: { message: @upload.errors.full_messages.join(',') }
    end
  end

  private
  def picture_params
    params.require(:picture).permit(:image)
  end
end
