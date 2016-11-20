class Property < ApplicationRecord
  belongs_to :landlord, class_name: 'User', foreign_key: "uid"
  belongs_to :tenant, class_name: 'User', optional: true

  def self.search(criteria)
    # local variables
    wildcard = '%'
    max_price = 10_000
    max_rooms = 100

    # check for empty values from the frontend and give them default
    # values
    criteria['zipcode'] = wildcard if criteria['zipcode'] == ''

    criteria['priceMin'] = 0 if criteria['priceMin'] == ''

    criteria['priceMax'] = max_price if criteria['priceMax'] == ''

    criteria['roomsMin'] = 0 if criteria['roomsMin'] == ''

    criteria['roomsMax'] = max_rooms if criteria['roomsMax'] == ''

    criteria['propertyType'] = wildcard if criteria['propertyType'] == ''

    puts 'Performing search'
    puts criteria['zipcode']

    # fetch proper where statement
    if criteria['zipcode'] == '%'
        where(
            'zipcode ILIKE ? AND (price >= ? AND price <= ?) AND (num_bedrooms >= ? AND num_bedrooms <= ? ) AND property_type ILIKE ?',
            criteria['zipcode'], criteria['priceMin'], criteria['priceMax'],
            criteria['roomsMin'], criteria['roomsMax'], criteria['propertyType']
        )
    else
        where(
            'zipcode IN (?) AND (price >= ? AND price <= ?) AND (num_bedrooms >= ? AND num_bedrooms <= ? ) AND property_type ILIKE ?',
            criteria['zipcode'], criteria['priceMin'], criteria['priceMax'],
            criteria['roomsMin'], criteria['roomsMax'], criteria['propertyType']
        )
    end
  end
end
