class Property < ApplicationRecord

    # Usage: self.search(search)
    # Pre: search is the
    def self.search(criteria)
        wildcard = '%'
        maxPrice = 10_000
        maxRooms = 100

        search['zipcode'] = wildcard if search['zipcode'] == ''

        search['priceMin'] = 0 if search['priceMin'] == ''

        search['priceMax'] = maxPrice if search['priceMax'] == ''

        search['roomsMin'] = 0 if search['roomsMin'] == ''

        search['roomsMax'] = maxRooms if search['roomsMax'] == ''

        search['propertyType'] = wildcard if search['propertyType'] == ''

    puts "Performing search"
    puts search["zipcode"]
    if search["zipcode"] == "%"
      where(
        "zipcode ILIKE ? AND (price >= ? AND price <= ?) AND (num_bedrooms >= ? AND num_bedrooms <= ? ) AND property_type ILIKE ?",
        search["zipcode"], search["priceMin"], search["priceMax"],
        search["roomsMin"], search["roomsMax"], search["propertyType"]
      )
    else
      where(
        "zipcode IN (?) AND (price >= ? AND price <= ?) AND (num_bedrooms >= ? AND num_bedrooms <= ? ) AND property_type ILIKE ?",
        search["zipcode"], search["priceMin"], search["priceMax"],
        search["roomsMin"], search["roomsMax"], search["propertyType"]
      )
    end

  end
end
