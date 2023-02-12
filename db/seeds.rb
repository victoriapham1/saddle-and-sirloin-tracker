# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Announcement.create(title: "First Announcement!", description: "This is the description!")
Announcement.create(title: "Second Announcement!", description: "This is the second description!")
Admin.create(email: "evanburriola12@tamu.edu")