# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Property.delete_all

Property.create!([
  {id:"175d8ecf-6d8c-40b9-aa18-19532388a878", address: "Eggertsgata 23", zipcode: "101", city: "Reykjavík",
    price: 3000, size: 105,
    num_bedrooms: 2, num_bathrooms: 2, property_type: "Parhús", lat: 64.135796,lon: -21.951066},
  {id:"451534e5-3127-4965-91d9-50a4c4c7c4ec", address: "Melhagi 54", zipcode: "107", city: "Reykjavík",
    price: 3500, size: 174,
    num_bedrooms: 3, num_bathrooms: 2, property_type: "Einbýlishús", lat: 64.143870, lon: -21.961279},
  {id:"e2052ecd-009b-407c-86ae-c15e530f9027", address: "Háagerði 2", zipcode: "600", city: "Akureyri",
    price: 1750, size: 75,
    num_bedrooms: 1, num_bathrooms: 1, property_type: "Einbýlishús", lat: 65.681785, lon: -18.117302},
  {id:"9301be0a-0f9c-409d-b013-622f488a2088", address: "Smyrlahraun 5", zipcode: "220", city: "Hafnarfjörður",
    price: 2350, size: 136,
    num_bedrooms: 2, num_bathrooms: 2, property_type: "Einbýlishús", lat: 64.071343, lon: -21.949604},
  {id:"87a3b4fd-929c-4133-900d-ad0e31e2f91c", address: "Hraunberg 5", zipcode: "111", city: "Reykjavik",
    price: 3500, size: 160, num_bedrooms: 4, num_bathrooms: 2, property_type: "Parhús", lat: 64.105512, lon: -21.812923},
  {id:"f959a6b2-7b28-46af-ba82-b3c5d610db4c", address: "Hilton Reykjavik Nordica", zipcode: "108", city: "Akureyri",
    price: 5000, size: 200, num_bedrooms: 10, num_bathrooms: 5, property_type: "Fjölbýlishús", lat: 64.139823, lon: -21.888772},

])
