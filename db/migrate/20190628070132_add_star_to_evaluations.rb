class AddStarToEvaluations < ActiveRecord::Migration[5.2]
  def change
    add_column :evaluations, :star, :integer
  end
end
