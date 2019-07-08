class VolumesController < ApplicationController
  before_action :logged_in_user, only: [:picture_position_show, :change_position, :new, :create, :edit, :update, :destroy]
  before_action :evaluations_number
  
  def index
    @pictures = Volume.find_by(id: params[:id]).pictures
  end
  
  def show
    @book = Book.find_by(id: params[:id])
    @volumes = @book.volumes
    @favorite_count = @book.favorites.count
    unless current_user.nil?
      @evaluation = current_user.evaluations.find_by(book_id: @book.id)
    end
  end
  
  def picture_position_show
    @pictures = Picture.where(volume_id: params[:id]).includes(:volume).order(:position)
  end
  
  def picture_show
    @picture = Picture.where(volume_id: params[:id]).includes(:volume).order(:position).first
    if @picture.nil?
      @book = Volume.find_by(id: params[:id]).book
      redirect_to volume_path(@book.id)
    else
      render :layout => 'picuture-prevu'
    end
  end
  
  def picture_show_chenge
    case params[:move]
    when 'up'
      @position = params[:position].to_i + 1
      @picture = Picture.find_by(volume_id: params[:id], position: @position)
      if @picture.nil?
        @picture = Picture.find_by(volume_id: params[:id], position: params[:position])
      end
    when 'down'
      @position = params[:position].to_i - 1
      @picture = Picture.find_by(volume_id: params[:id], position: @position)
      if @picture.nil?
        @picture = Picture.find_by(volume_id: params[:id], position: params[:position])
      end
    else
      return head :ok
    end
  end
  
  def picture
    @picture = Picture.where(volume_id: params[:id]).order(:position).first
  end
  
  def change_position
    case params[:move]
    when 'up'
      @picture = Picture.find(params[:id])
      @picture.move_higher
      @target = @picture.lower_item
    when 'down'
      @picture = Picture.find(params[:id])
      @picture.move_lower
      @target = @picture.higher_item
    else
      return head :ok
    end
  end
  
  def new
    @volume = Book.find_by(id: params[:id]).volumes.new
        1.times { @volume.pictures.build }
  end
  
  def create
    @book = Book.find_by(id: params[:volume][:id])
    @volume = @book.volumes.build(volume_params)
    if @volume.save && !picture_params[:pictures_attributes]["0"][:picture].nil?
      picture_params[:pictures_attributes]["0"][:picture].map do |d|
        @volume.pictures.create!(picture: d)
      end
      flash[:success] = "volume created"
      redirect_to volume_path(id: @volume.book_id)
    else
      if picture_params[:pictures_attributes]["0"][:picture].nil?
        flash.now[:danger] = "画像が選択されていません。"
      end
      1.times { @volume.pictures.build }
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
      flash[:success] = "volume updated"
      redirect_to volume_path(id: @volume.book_id)
    else
      1.times { @volume.pictures.build }
      render :edit
    end
  end
  
  def destroy
    @volume = Volume.find(params[:id])
    @book = Book.find_by(id: @volume.book_id)
    @volume.destroy
    flash[:success] = "volume deleted"
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
