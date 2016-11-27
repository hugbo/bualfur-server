class AddAttachmentImage3ToProperties < ActiveRecord::Migration
  def self.up
    change_table :properties do |t|
      t.attachment :image3
    end
  end

  def self.down
    remove_attachment :properties, :image3
  end
end
