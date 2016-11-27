class AddAttachmentImage4ToPropertyPhotos < ActiveRecord::Migration
  def self.up
    change_table :property_photos do |t|
      t.attachment :image4
    end
  end

  def self.down
    remove_attachment :property_photos, :image4
  end
end
