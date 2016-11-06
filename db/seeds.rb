# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Property.delete_all

Property.create!([
  {id:"1", address: "Eggertsgata 23", zipcode: "101", city: "Reykjavík",
    price: 3000, size: 105,
    num_bedrooms: 2, num_bathrooms: 2, property_type: "Parhús"},
  {id:"2", address: "Melhagi 54", zipcode: "107", city: "Reykjavík",
    price: 3500, size: 174,
    num_bedrooms: 3, num_bathrooms: 2, property_type: "Einbýlishús"},
  {id:"3", address: "Háagerði 2", zipcode: "600", city: "Akureyri",
    price: 1750, size: 75,
    num_bedrooms: 1, num_bathrooms: 1, property_type: "Einbýlishús"},
  {id:"4", address: "Bjargstræti 5", zipcode: "221", city: "Hafnarfjörður",
    price: 2350, size: 136,
    num_bedrooms: 2, num_bathrooms: 2, property_type: "Einbýlishús"}
])
