class UpdateUserPermissions < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :name, :first_name
    add_column :users, :last_name, :string
    add_column :users, :gender, :string
    add_column :users, :age_range, :string
  end
end


# id, first_name, last_name, gender, age_range, link
