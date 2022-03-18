# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# crea 2 usuarios con role "Admin"
2.times do |i|
  User.create!(name: "admin-#{i+1}",
    email: "admin-#{i+1}@email.com",
    role: 0,
    password: "123456",
    password_confirmation: "123456")
  end

# crea 2 usuarios con role "Member"
2.times do |i|
  User.create!(name: "member-#{i+1}",
              email: "member-#{i+1}@email.com",
              role: 1,
              password: "123456",
              password_confirmation: "123456")
  User.last.update(role: 1)
end

Housing.create!(name: "Housing Demo", status: "Active", user_id: User.first.id)

HousingUser.create!(user_id: User.first.id, housing_id: Housing.first.id)

SuperUser.create!(email: 'super@email.com', password: '123456', password_confirmation: '123456') if Rails.env.development?