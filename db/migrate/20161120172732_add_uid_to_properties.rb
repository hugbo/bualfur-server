class AddUidToProperties < ActiveRecord::Migration[5.0]
  def change
    add_column :properties, :uid, :string
  end
end
