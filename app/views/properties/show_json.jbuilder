json.property_id @property.id
json.address @property.address
json.zipcode @property.zipcode
json.city @property.city
json.price @property.price
json.size @property.size
json.property_type @property.property_type
json.rooms @property.num_bedrooms
json.bathrooms @property.num_bathrooms
json.gpslocation do
  json.lat @property.lat
  json.lng @property.lon
end

json.landlord do
  json.first_name @property.landlord.first_name
  json.last_name @property.landlord.last_name
  json.image_url @property.landlord.image_url
  json.facebook_url @property.landlord.url
  json.phone_number @property.landlord.phone_number
  json.personal_info @property.landlord.personal_info
  json.email @property.landlord.email
end

json.images [@property.image1.url, @property.image2.url,@property.image3.url,@property.image4.url, ]
