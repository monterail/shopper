# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: "peanutbutter@mail.com", password: "peanut1", password_confirmation: "peanut1", role: "admin")
User.create(email: "john.doe@mail.com", password: "password", password_confirmation: "password")

Product.create(brand: "Apple", model: "Iphone 7", price: 2999.99, quantity_in_stock: 10)
Product.create(brand: "Samsung", model: "Galaxy S8", price: 2000.00, quantity_in_stock: 20)
Product.create(brand: "Xiaomi", model: "Mi Mix", price: 1555.55, quantity_in_stock: 30)
