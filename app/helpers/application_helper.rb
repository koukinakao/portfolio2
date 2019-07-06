module ApplicationHelper
    
  def evalu_average(evalu)
    evalu.evaluations.average(:star).round(1)
  end
  
  def evalu_average(book)
    book.evaluations.average(:star).round(1)
  end
end
