class RenameLandlordColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :properties, :landlord, :landlord_reference
  end
end
