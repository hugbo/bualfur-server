class RemoveLandlordReference < ActiveRecord::Migration[5.0]
  def change
    remove_column :properties, :landlord_reference
  end
end
