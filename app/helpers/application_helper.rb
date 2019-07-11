module ApplicationHelper
    
  def evalu_average(book)
    unless book.evaluations.blank?
      book.evaluations.average(:star).round(1)
    else
      0
    end
  end
  
  def full_title(page_title = '')
    base_title = "portfolio"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
