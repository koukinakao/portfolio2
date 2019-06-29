class ChangeDataPositionToPictures < ActiveRecord::Migration[5.2]
  def change
    if Rails.env.development? || Rails.env.test?
      change_column :pictures, :position, :integer 
    else Rails.env.production?
      change_column :pictures, :position, 'integer USING CAST(position AS integer)'
    end
  end
end
