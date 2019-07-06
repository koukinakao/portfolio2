module ApplicationHelper
    
  def evalu_average(evalu)
    evalu.evaluations.average(:star)
  end
end
