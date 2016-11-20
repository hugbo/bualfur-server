# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all

User.create!(first_name: "Pepe", provider: "facebook", uid: "10210810816927",
  created_at: DateTime.new(2001,2,3,4,5,6), updated_at: DateTime.current)

Property.delete_all

property_list = [
  ["175d8ecf-6d8c-40b9-aa18-19532388a878", "Eggertsgata 23", "101", "Reykjavík",
    3000, 105, 2, 2, "Parhús", 64.135796, -21.951066 ],
  ["451534e5-3127-4965-91d9-50a4c4c7c4ec", "Melhagi 54", "107", "Reykjavík",
    3500, 174, 3, 2, "Einbýlishús", 64.143870,  -21.961279 ],
  ["e2052ecd-009b-407c-86ae-c15e530f9027", "Háagerði 2", "600", "Akureyri",
    1750, 75, 1, 1, "Einbýlishús", 65.681785,  -18.117302 ],
  ["9301be0a-0f9c-409d-b013-622f488a2088", "Smyrlahraun 5", "220", "Hafnarfjörður",
    2350, 136, 2, 2, "Einbýlishús", 64.071343,  -21.949604 ],
  ["87a3b4fd-929c-4133-900d-ad0e31e2f91c", "Hraunberg 5", "111", "Reykjavik",
    3500, 160, 4, 2, "Parhús", 64.105512,  -21.812923 ],
  ["f959a6b2-7b28-46af-ba82-b3c5d610db4c", "Hilton Reykjavik Nordica", "108", "Akureyri",
    5000, 200, 10, 5, "Fjölbýlishús", 64.139823,  -21.888772 ]
]

tmp_landlord = User.where(:uid => "10210810816927").first

property_list.each do |id, address, zipcode, city, price, size, num_bedrooms,
  num_bathrooms, property_type, lat, lon|

  prop = Property.create!(id: id, address: address, zipcode: zipcode, city: city,
    price: price, size: size, num_bedrooms: num_bedrooms,
    num_bathrooms: num_bathrooms, property_type: property_type,
    lat: lat, lon: lon, landlord: tmp_landlord)

  prop.landlord = tmp_landlord


  puts prop.landlord
 end

 puts Property.where(:zipcode => "101").first.landlord.uid
