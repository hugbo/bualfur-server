class CreatePropertyPhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :property_photos do |t|
      t.string :prop_id

      t.timestamps
    end
  end
end
