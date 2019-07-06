class BooksController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :evaluations_number

  def posts_index
    @user = User.find_by(id: params[:id])
    @books = Book.where(user_id: @user.id)
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
      flash[:success] = "book created"
      redirect_to books_posts_path(id: @book.user_id)
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
      flash[:success] = "book updated"
      redirect_to books_posts_path
    else
      render :edit
    end
  end
  
  def destroy
    @book = Book.find(params[:id]).destroy
    flash[:success] = "book deleted"
    redirect_to books_posts_path
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :content, :picture, :remove_picture)
  end
end
