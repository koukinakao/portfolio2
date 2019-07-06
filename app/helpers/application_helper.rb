module ApplicationHelper
    
  def evalu_average(evalu)
    evalu.evaluations.average(:star).round(1)
  end
end
