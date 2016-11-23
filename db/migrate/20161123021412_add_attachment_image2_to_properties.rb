class AddAttachmentImage2ToProperties < ActiveRecord::Migration
  def self.up
    change_table :properties do |t|
      t.attachment :image2
    end
  end

  def self.down
    remove_attachment :properties, :image2
  end
end
