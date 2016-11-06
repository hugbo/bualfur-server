class AddCoordinatesToProperties < ActiveRecord::Migration[5.0]
  def change
    add_column :properties, :lat, :float
    add_column :properties, :lon, :float
  end
end
