class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.string :picture
      t.integer :position

      t.timestamps
    end
  end
end
