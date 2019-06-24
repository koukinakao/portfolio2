class ChangeDataPositionToPictures < ActiveRecord::Migration[5.2]
  def change
    change_column :pictures, :position, :integer
  end
end
