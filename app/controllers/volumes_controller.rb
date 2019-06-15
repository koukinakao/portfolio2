class VolumesController < ApplicationController
  def show
    @book = Book.find_by(params[:id])
    @volumes = @book.volumes
  end

  def new
    @volume = Book.find_by(id: params[:id]).volumes.build
  end
  
  def create
    @book = Book.find_by(params[:id])
    @volume = @book.volumes.build(volume_params)
    if @volume.save
      redirect_to volume_path(@book)
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
end
