class DropTables < ActiveRecord::Migration[5.0]
  def change
    drop_table :landlords_properties
    drop_table :tenants_properties
  end
end
