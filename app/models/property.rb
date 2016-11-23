class Property < ApplicationRecord
  # Database associations
  belongs_to :landlord, class_name: 'User', foreign_key: "uid"
  belongs_to :tenant, class_name: 'User', optional: true

  # Paperclip gem assertions
  @hash = ENV["HASH_SEED"]
  has_attached_file :image1, url: "/photos/:hash.:extension", hash_secret: @hash
  has_attached_file :image2, url: "/photos/:hash.:extension", hash_secret: @hash
  has_attached_file :image3, url: "/photos/:hash.:extension", hash_secret: @hash
  has_attached_file :image4, url: "/photos/:hash.:extension", hash_secret: @hash
  validates_attachment :image1, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
  validates_attachment :image2, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
  validates_attachment :image3, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
  validates_attachment :image4, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

  # Method to search database for properties meeting criteria
  def self.search(criteria)
    # local variables
    wildcard = '%'
    max_price = 10_000_000
    max_rooms = 100
    max_sqm   = 10_000

    puts criteria

    # check for empty values from the frontend and give them default
    # values

    criteria['zipcode'] = wildcard if criteria['zipcode'] == ''

    criteria['price_min'] = 0 if criteria['price_min'] == ''

    criteria['price_max'] = max_price if criteria['price_max'] == ''

    criteria['rooms_min'] = 0 if criteria['rooms_min'] == ''

    criteria['rooms_max'] = max_rooms if criteria['rooms_max'] == ''

    criteria['rooms_max'] = max_rooms if criteria['rooms_max'] == '7'

    criteria['property_type'] = wildcard if criteria['property_type'] == ''

    criteria['square_meters_min'] = 0 if criteria['square_meters_min'] == '0'

    criteria['square_meters_max'] = max_sqm if criteria['square_meters_max'] == '0'


    # fetch proper where statement
    if criteria['zipcode'] == wildcard && criteria['property_type'] == wildcard
        where(
            'zipcode ILIKE ? AND (price >= ? AND price <= ?) AND (num_bedrooms >= ? AND num_bedrooms <= ? ) AND (size >= ? AND size <= ?) AND property_type ILIKE ?',
            criteria['zipcode'], criteria['price_min'], criteria['price_max'],
            criteria['rooms_min'], criteria['rooms_max'], criteria['square_meters_min'],
            criteria['square_meters_max'], criteria['property_type']
        )
    elsif criteria['zipcode'] == wildcard
      where(
          'zipcode ILIKE ? AND (price >= ? AND price <= ?) AND (num_bedrooms >= ? AND num_bedrooms <= ? ) AND (size >= ? AND size <= ?) AND property_type IN (?)',
          criteria['zipcode'], criteria['price_min'], criteria['price_max'],
          criteria['rooms_min'], criteria['rooms_max'], criteria['square_meters_min'],
          criteria['square_meters_max'], criteria['property_type']
      )
    elsif criteria['property_type'] == wildcard
      where(
          'zipcode IN (?) AND (price >= ? AND price <= ?) AND (num_bedrooms >= ? AND num_bedrooms <= ? ) AND (size >= ? AND size <= ?) AND property_type ILIKE ?',
          criteria['zipcode'], criteria['price_min'], criteria['price_max'],
          criteria['rooms_min'], criteria['rooms_max'], criteria['square_meters_min'],
          criteria['square_meters_max'], criteria['property_type']
      )
    else
        where(
            'zipcode IN (?) AND (price >= ? AND price <= ?) AND (num_bedrooms >= ? AND num_bedrooms <= ? ) AND (size >= ? AND size <= ?) AND property_type IN (?)',
            criteria['zipcode'], criteria['price_min'], criteria['price_max'],
            criteria['rooms_min'], criteria['rooms_max'], criteria['square_meters_min'],
            criteria['square_meters_max'], criteria['property_type']
        )
    end
  end
end
