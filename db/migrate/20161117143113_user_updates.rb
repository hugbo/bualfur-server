class UserUpdates < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_landlord, :boolean
    add_column :users, :is_render, :boolean
    add_column :users, :phone_number, :string
    add_column :users, :personal_info, :string
  end
end
