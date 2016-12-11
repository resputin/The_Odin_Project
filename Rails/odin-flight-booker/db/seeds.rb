# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Airport.create!(code: "SFO")
Airport.create!(code: "NYC")
Airport.create!(code: "SDG")
Airport.create!(code: "LAX")
Airport.create!(code: "BOS")

Flight.create!(origin_id: 1, destination_id: 2, takeoff: Time.now, duration: 100, takeoff_date: Date.today)