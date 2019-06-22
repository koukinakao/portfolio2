class BooksController < ApplicationController
  before_action :logged_in_user
  
  def posts_index
    @books = Book.where(user_id: current_user.id)
  end

  def viewer_index
    @books = Book.all
  end

  def new
    @book = current_user.books.build
  end
  
  def create
    @book = current_user.books.build(book_params)
    if @book.save
      redirect_to books_posts_path
    else
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to books_posts_path
    else
      render :edit
    end
  end
  
  def destroy
    @book = Book.find(params[:id]).destroy
    redirect_to books_posts_path
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :content, :picture, :remove_picture)
  end
end
