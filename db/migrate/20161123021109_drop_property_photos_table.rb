class DropPropertyPhotosTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :property_photos
  end
end
