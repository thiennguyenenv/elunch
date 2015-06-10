# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "seed default users - Admin"
users = [{
    email: 'admin@elunch.com',
    password: 'password1',
    first_name: 'Admin',
    last_name: 'Admin',
    admin: true
  }]

users.each do |user|
  unless User.find_by_email(user[:email])
    User.create!(user)
  end
end
