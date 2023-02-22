# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Announcement.create(title: "First Announcement!", description: "This is the description!")
Announcement.create(title: "Second Announcement!", description: "This is the second description!")
Announcement.create(title: "Third Announcement!", description: "This is the third description!")
Announcement.create(title: "Fourth Announcement!", description: "This is the fourth description!")

Event.create(name: "Cookout",event_type: 3, date: '12/12/2023', description: "cookout where you can meet fellow members.")
Event.create(name: "Tailgate",event_type: 2, date: '3/12/2023', description: "Tailgate for the jump-rope committee team.")
Event.create(name: "Jump-rope world finals",event_type: 1, date: '3/13/2023', description: "World Championship competition!")
Event.create(name: "Saddlin'",event_type: 2, date: '4/12/2023', description: "Saddlin' with the boys.")
Event.create(name: "Sirloinin'",event_type: 2, date: '5/12/2023', description: "Cookin up something good!")

User.create(uin: "111222333", first_name: "Tryston", last_name: "Burriola", email: "trystonburriola@tamu.edu", phone: "5125952682", password: "password", isActive: true, role: 0, classify: 1)
User.create(uin: "987654321", first_name: "Rees", last_name: "Merrifield", email: "rees.mfield@tamu.edu", phone: "2106632682", password: "password123", isActive: true, role: 0, classify: 2)
User.create(uin: "527357234", first_name: "Baylee", last_name: "Burriola", email: "baylee_burriola27@tamu.edu", phone: "4436432211", password: "password321", isActive: true, role: 1, classify: 4)
User.create(uin: "120000342", first_name: "Joshua", last_name: "Inman", email: "josh-inman@tamu.edu", phone: "9794559160", password: "password132", isActive: true, role: 1, classify: 3)
User.create(uin: "110003421", first_name: "Chaney", last_name: "McIntier", email: "chaney.mcintier@tamu.edu", phone: "2105556789", password: "password312", isActive: true, role: 0, classify: 2)
User.create(uin: "111222333", first_name: "Eric", last_name: "Burriola", email: "ericpb@tamu.edu", phone: "5126635588", password: "password_", isActive: true, role: 1, classify: 4)
User.create(uin: "987654321", first_name: "Sharon", last_name: "Burriola", email: "sburriola@tamu.edu", phone: "5126635163", password: "password_123", isActive: true, role: 0, classify: 2)
User.create(uin: "527357234", first_name: "Conner", last_name: "Burriola", email: "conner.burriola@tamu.edu", phone: "4106432211", password: "_password321", isActive: true, role: 0, classify: 1)
User.create(uin: "120000342", first_name: "Trevor", last_name: "Gentry", email: "tgentry@tamu.edu", phone: "9794559160", password: "password132!", isActive: true, role: 0, classify: 1)
User.create(uin: "110003421", first_name: "Ryan", last_name: "Porter", email: "porter_ryan@tamu.edu", phone: "2105556789", password: "password312_!", isActive: true, role: 0, classify: 1)
User.create(uin: "987654321", first_name: "Betty", last_name: "White", email: "betty@tamu.com", phone: "2814946001", password: "test", isActive: true, role: 0, classify: 1)
User.create(uin: "985615879", first_name: "John", last_name: "Trinh", email: "john@tamu.com", phone: "2818751025", password: "johnny123", isActive: true, role: 0, classify: 1)
User.create(uin: "123548681", first_name: "Leslie", last_name: "Alexander", email: "leslie@tamu.com", phone: "8321258754", password: "leslie", isActive: true, role: 0, classify: 1)
User.create(uin: "845657821", first_name: "Anna", last_name: "Nguyen", email: "anna@tamu.com", phone: "9051207851", password: "annang", isActive: true, role: 0, classify: 1)
User.create(uin: "654854102", first_name: "Parash", last_name: "Nanah", email: "parash@tamu.com", phone: "1024569842", password: "parash", isActive: true, role: 0, classify: 1)
User.create(uin: "785452102", first_name: "Alex", last_name: "Black", email: "alex@tamu.com", phone: "1237851028", password: "alex", isActive: true, role: 0, classify: 1)
User.create(uin: "456850015", first_name: "Amy", last_name: "Tran", email: "amy@tamu.com", phone: "8323066612", password: "amy", isActive: true, role: 0, classify: 1)
User.create(uin: "651245870", first_name: "Kasey", last_name: "Amiela", email: "kasey@tamu.com", phone: "8321234567", password: "kasey", isActive: true, role: 0, classify: 1)
User.create(uin: "456789452", first_name: "Crystal", last_name: "Phan", email: "crystal@tamu.com", phone: "8323014569", password: "crystal", isActive: true, role: 0, classify: 1)
User.create(uin: "789542120", first_name: "Brooke", last_name: "Errington", email: "brooke@tamu.com", phone: "2819791023", password: "brooke", isActive: true, role: 0, classify: 1)