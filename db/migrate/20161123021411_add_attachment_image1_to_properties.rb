class AddAttachmentImage1ToProperties < ActiveRecord::Migration
  def self.up
    change_table :properties do |t|
      t.attachment :image1
    end
  end

  def self.down
    remove_attachment :properties, :image1
  end
end
