class EvaluationsController < ApplicationController
  before_action :logged_in_user
  before_action :evaluations_number
  
  def show
    @book = Book.find_by(id: params[:book_id])
    @evaluations = Book.find_by(id: @book.id).evaluations
    @user_evaluation = @evaluations.find_by(user_id: current_user.id)
  end
  
  def new
    @evaluation = current_user.evaluations.build
    @book = Book.find_by(id: params[:book_id])
  end
  
  def create
    @book = Book.find_by(id: evaluation_params[:book_id])
    @evaluation = current_user.evaluations.build(evaluation_params)
    if @evaluation.save
      redirect_to volume_path(id: @book.id)
    else
      render :new
    end
  end

  def edit
    @book = Book.find_by(id: params[:book_id])
    @evaluation = current_user.evaluations.find_by(book_id: @book.id)
  end
  
  def update
    @book = Book.find_by(id: evaluation_params[:book_id])
    @evaluation = current_user.evaluations.find_by(book_id: @book.id)
    if @evaluation.update(evaluation_params)
      redirect_to volume_path(id: @book.id)
    else
      render :edit
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
