class Property < ApplicationRecord
  def self.search(search)
    where("zipcode ILIKE ? OR price ILIKE ?", "%#{search}%", "%#{search}%")
  end
end
