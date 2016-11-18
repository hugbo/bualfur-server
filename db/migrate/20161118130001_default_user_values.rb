class DefaultUserValues < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :is_render, :is_renter
    change_column :users, :is_renter, :boolean, :default => false
    change_column :users, :is_landlord, :boolean, :default => false
    change_column :users, :personal_info, :string, :default => ""
  end
end
