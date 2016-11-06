class ChangeZipcodetype < ActiveRecord::Migration[5.0]
  def change
    change_column :properties, :zipcode, :string
  end
end
