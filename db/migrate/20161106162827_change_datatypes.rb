class ChangeDatatypes < ActiveRecord::Migration[5.0]
  def change
    change_column :properties, :zipcode, 'integer USING CAST(zipcode as integer)'
    change_column :properties, :price, 'integer USING CAST(price as integer)'
    change_column :properties, :size, 'integer USING CAST(size as integer)'
    change_column :properties, :num_bedrooms, 'integer USING CAST(num_bedrooms as integer)'
    change_column :properties, :num_bathrooms, 'integer USING CAST(num_bathrooms as integer)'
  end
end
