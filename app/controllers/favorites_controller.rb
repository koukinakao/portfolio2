class FavoritesController < ApplicationController
  
  def create
    @book = Book.find_by(id: params[:book_id])
    @id_name = "#like-link-#{@book.id}"
    if Favorite.where(user_id: current_user.id, book_id: @book.id)
      current_user.favorites.create(book_id: @book.id)
    end
  end
  
  def destroy
    @book = Book.find_by(id: params[:book_id])
    @id_name = "#like-link-#{@book.id}"
    @favorite = current_user.favorites.find_by(book_id: @book.id)
    @favorite.destroy
  end
end
