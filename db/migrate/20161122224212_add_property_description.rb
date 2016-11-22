class AddPropertyDescription < ActiveRecord::Migration[5.0]
  def change
    add_column :properties, :description, :string
  end
end
