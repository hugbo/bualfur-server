class AddAttachmentImage1ToPropertyPhotos < ActiveRecord::Migration
  def self.up
    change_table :property_photos do |t|
      t.attachment :image1
    end
  end

  def self.down
    remove_attachment :property_photos, :image1
  end
end
