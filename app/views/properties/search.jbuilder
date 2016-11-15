json.properties @properties do |property|
  json.property_id property.id
  json.address property.address
  json.zipcode property.zipcode
  json.price property.price
  json.size property.size
  json.property_type property.property_type
  json.gpslocation do
    json.lat property.lat
    json.lon property.lon
  end

end
