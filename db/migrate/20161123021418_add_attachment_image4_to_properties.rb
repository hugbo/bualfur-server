class AddAttachmentImage4ToProperties < ActiveRecord::Migration
  def self.up
    change_table :properties do |t|
      t.attachment :image4
    end
  end

  def self.down
    remove_attachment :properties, :image4
  end
end
