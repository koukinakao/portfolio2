module ApplicationHelper
    
  def evalu_average(book)
    book.evaluations.average(:star).round(1)
  end
end
