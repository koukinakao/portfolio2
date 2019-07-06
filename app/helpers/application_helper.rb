module ApplicationHelper
    
  def evalu_average(book)
    unless book.evaluations.blank?
      book.evaluations.average(:star).round(1)
    else
      0
    end
  end
end
