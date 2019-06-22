class VolumesController < ApplicationController
  
  def index
    @pictures = Volume.find_by(id: params[:id]).pictures
  end
  
  def show
    @book = Book.find_by(id: params[:id])
    @volumes = @book.volumes
    @favorite_count = @book.favorites.count
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
        picture = @volume.pictures.create!(picture: d)
      end
      redirect_to volume_path(id: @volume.book_id)
    else
      render :new
    end
  end

  def edit
    @volume = Volume.find(params[:id])
     1.times { @volume.pictures.build }
  end
  
  def update
    @volume = Volume.find(params[:id])
    if @volume.update(volume_params)
      picture_params[:pictures_attributes].each do |g|
        if g[1][:id].empty?
          unless g[1][:picture].nil?
            g[1][:picture].map do |pic|
              @volume.pictures.create!(picture: pic)
            end
          end
        else
          @picture = Picture.find(g[1][:id])
          if g[1][:remove_picture] == "1" || g[1][:remove_picture].nil?
            @picture.destroy
          elsif !g[1][:picture].nil?
            g[1][:picture].map do |pic|
              @picture.update(picture: pic)
            end
          end
        end
      end
      redirect_to volume_path(id: @volume.book_id)
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
    params.require(:volume).permit(pictures_attributes: {})
  end
  
  
end
