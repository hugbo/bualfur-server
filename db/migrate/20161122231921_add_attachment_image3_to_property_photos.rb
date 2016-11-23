class AddAttachmentImage3ToPropertyPhotos < ActiveRecord::Migration
  def self.up
    change_table :property_photos do |t|
      t.attachment :image3
    end
  end

  def self.down
    remove_attachment :property_photos, :image3
  end
end
