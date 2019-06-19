class AddIndexReferencesToPicture < ActiveRecord::Migration[5.2]
  def change
    add_reference :pictures, :volume, foreign_key: true
  end
end
