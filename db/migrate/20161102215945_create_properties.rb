class CreateProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :properties do |t|
      t.string :address
      t.string :zipcode
      t.string :city
      t.string :price
      t.string :size
      t.string :numBedrooms
      t.string :numBathrooms
      t.string :propertyType

      t.timestamps
    end
  end
end
