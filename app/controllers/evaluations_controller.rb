class EvaluationsController < ApplicationController
  
  def show
    
  end
  
  def new
    @evaluation = current_user.evaluations.build
    @book = Book.find_by(id: params[:book_id])
  end
  
  def create
    @book = Book.find_by(id: evaluation_params[:book_id])
    if @evaluation = current_user.evaluations.find_by(book_id: @book.id)
      render :new, book: @book
    else
      @evaluation = current_user.evaluations.create(evaluation_params)
      redirect_to volume_path(id: @book.id)
    end
  end

  def edit
    @book = Book.find_by(id: params[:book_id])
    @evaluation = current_user.evaluations.find_by(book_id: @book.id)
  end
  
  def update
    debugger
    @book = Book.find_by(id: evaluation_params[:book_id])
    @evaluation = current_user.evaluations.find_by(book_id: @book.id)
    if @evaluation.update(evaluation_params)
      redirect_to volume_path(id: @book.id)
    else
      render :edit, book: @book
    end
  end
  
  def destroy
    @book = Book.find_by(id: params[:book_id])
    @evaluation = current_user.evaluations.find_by(book_id: @book.id)
    @evaluation.destroy
    redirect_to volume_path(id: @book.id)
  end
  
  private
  
  def evaluation_params
    params.require(:evaluation).permit(:comment, :book_id, :star)
  end

end
