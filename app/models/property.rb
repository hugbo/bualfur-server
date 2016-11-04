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
    # where("zipcode ILIKE ? OR price , "%#{search["zipcode"]}%", "%#{search["minPrice"]}%")
    where(
      "zipcode ILIKE ? AND (price BETWEEN ? AND ?) AND (num_bedrooms BETWEEN ? AND ? ) AND property_type ILIKE ?",
      "%#{search["zipcode"]}%", "%#{search["priceMin"]}%", "%#{search["priceMax"]}%",
      "%#{search["roomsMin"]}%", "%#{search["roomsMax"]}%", "%#{search["propertyType"]}%"
    )
  end
end
