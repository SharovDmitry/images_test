class Api::V1::ImagesController < ApplicationController
  before_action :find_image, only: :update

  def index
    images = current_user.images.all
    render json: images, status: :ok
  end

  def create
    image = current_user.images.new(image_create_params)
    if image.save
      render json: image, status: :ok
    else
      render_error(image, :unprocessable_entity)
    end
  end

  def update
    if @image.update(image_resize_params)
      @image.file.recreate_versions!
      render json: @image, status: :ok
    else
      render_error(@image, :unprocessable_entity)
    end
  end

  private

  def find_image
    @image = current_user.images.find(params[:id])
    head :not_found and return unless @image
  end

  def image_create_params
    params.require(:image).permit(:width, :height, :file)
  end

  def image_resize_params
    params.require(:image).permit(:width, :height)
  end
end
