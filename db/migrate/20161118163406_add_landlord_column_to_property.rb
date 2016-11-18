class AddLandlordColumnToProperty < ActiveRecord::Migration[5.0]
  def change
    add_column :properties, :landlord, :string
  end
end
