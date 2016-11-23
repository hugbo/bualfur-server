class AddAttachmentImage2ToPropertyPhotos < ActiveRecord::Migration
  def self.up
    change_table :property_photos do |t|
      t.attachment :image2
    end
  end

  def self.down
    remove_attachment :property_photos, :image2
  end
end
