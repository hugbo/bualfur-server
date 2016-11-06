class Property < ApplicationRecord
  def self.search(search)

    wildcard = "%"
    maxPrice = 10000
    maxRooms = 100

    if search["zipcode"] == ""
      search["zipcode"] = wildcard
    end

    if search["priceMin"] == ""
      search["priceMin"] = 0
    end

    if search["priceMax"] == ""
      search["priceMax"] = maxPrice
    end

    if search["roomsMin"] == ""
      search["roomsMin"] = 0
    end

    if search["roomsMax"] == ""
      search["roomsMax"] = maxRooms
    end

    if search["propertyType"] == ""
      search["propertyType"] = wildcard
    end


    puts "Performing search"
    puts search["zipcode"]
    where(
      "zipcode ILIKE ? AND (price >= ? AND price <= ?) AND (num_bedrooms >= ? AND num_bedrooms <= ? ) AND property_type ILIKE ?",
      search["zipcode"], search["priceMin"], search["priceMax"],
      search["roomsMin"], search["roomsMax"], search["propertyType"]
    )
  end
end
