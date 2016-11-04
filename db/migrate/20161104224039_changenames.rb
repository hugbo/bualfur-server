class Changenames < ActiveRecord::Migration[5.0]
  def change
    rename_column :properties, :numBedrooms, :num_bedrooms
    rename_column :properties, :numBathrooms, :num_bathrooms
    rename_column :properties, :propertyType, :property_type
  end
end
