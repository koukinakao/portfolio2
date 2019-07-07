class EvaluationsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :evaluations_number
  
  def show
    @book = Book.find_by(id: params[:book_id])
    @evaluations = Book.find_by(id: @book.id).evaluations
    unless current_user.nil?
      @user_evaluation = @evaluations.find_by(user_id: current_user.id)
    end
  end
  
  def new
    @evaluation = current_user.evaluations.build
    @star = 0
    @book = Book.find_by(id: params[:book_id])
  end
  
  def create
    @book = Book.find_by(id: evaluation_params[:book_id])
    @evaluation = current_user.evaluations.build(evaluation_params)
    if @evaluation.save
      flash[:success] = "評価を更新しました。"
      redirect_to volume_path(id: @book.id)
    else
      flash.now[:danger] = '評価の更新に失敗しました。'
      render :new
    end
  end

  def edit
    @book = Book.find_by(id: params[:book_id])
    @evaluation = current_user.evaluations.find_by(book_id: @book.id)
    @star = @evaluation.star
  end
  
  def update
    @book = Book.find_by(id: evaluation_params[:book_id])
    @evaluation = current_user.evaluations.find_by(book_id: @book.id)
    if @evaluation.update(evaluation_params)
      flash[:success] = "評価を更新しました。"
      redirect_to volume_path(id: @book.id)
    else
      flash.now[:danger] = '評価の更新に失敗しました。'
      render :edit
    end
  end
  
  def destroy
    @book = Book.find_by(id: params[:book_id])
    @evaluation = current_user.evaluations.find_by(book_id: @book.id)
    @evaluation.destroy
    flash[:success] = "評価内容を削除しました。"
    redirect_to volume_path(id: @book.id)
  end
  
  private
  
  def evaluation_params
    params.require(:evaluation).permit(:comment, :book_id, :star)
  end

end
