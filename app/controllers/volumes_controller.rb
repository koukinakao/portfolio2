class VolumesController < ApplicationController
  
  def index
    @pictures = Volume.find_by(id: params[:id]).pictures
  end
  
  def show
    @book = Book.find_by(id: params[:id])
    @volumes = @book.volumes
  end

  def new
    @volume = Book.find_by(id: params[:id]).volumes.new
        1.times { @volume.pictures.build }
  end
  
  def create
    @book = Book.find_by(id: params[:volume][:id])
    @volume = @book.volumes.build(volume_params)
    if @volume.save
      picture_params[:pictures_attributes]["0"][:picture].map do |d|
        picture = @volume.pictures.create!(picture: d, position: 1)
      end
      redirect_to volume_path(id: @volume.book_id)
    else
      render :new
    end
  end

  def edit
    @volume = Volume.find(params[:id])
  end
  
  def update
    @volume = Volume.find(params[:id])
    if @volume.update(volume_params)
      redirect_to volume_path(@volume)
    else
      render :edit
    end
  end
  
  def destroy
    @volume = Volume.find(params[:id])
    @book = Book.find_by(id: @volume.book_id)
    @volume.destroy
    redirect_to volume_path(id: @book.id)
  end
  
  private
  
  def volume_params
    params.require(:volume).permit(:title, :content)
  end
  
  def picture_params
    params.require(:volume).permit(pictures_attributes: {picture: []})
  end
  
  
end
