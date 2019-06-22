class AddIndexUniqueTpEvaluations < ActiveRecord::Migration[5.2]
  def change
    add_index :evaluations, [:book_id, :user_id], unique: true
  end
end
