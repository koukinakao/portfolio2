class ApplicationController < ActionController::Base
  include SessionsHelper

  
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  
  def evaluations_number
    @evaluations = Evaluation.order(star: "DESC").group(:book_id).average(:star)
    @limit = 0
    @evaluations.each{|key, value| 
    @limit += 1
    @book = Book.find_by(id: key)
    if @evalutop.nil?
      @evalutop = [@book]
    else
      @evalutop += [@book] 
    end
      if @limit > 10 then
        break
      end
    }
  end
end
