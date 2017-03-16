json.properties @properties do |property|
  json.property_id property.id
  json.address property.address
  json.zipcode property.zipcode
  json.city property.city
  json.price property.price
  json.size property.size
  json.property_type property.property_type
  json.rooms property.num_bedrooms
  json.bathrooms property.num_bathrooms
  json.gpslocation do
    json.lat property.lat
    json.lng property.lon
  end

end
