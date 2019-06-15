class AddIndexReferencesToVolumes < ActiveRecord::Migration[5.2]
  def change
    add_reference :volumes, :book, foreign_key: true
  end
end
