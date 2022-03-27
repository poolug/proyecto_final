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
    role: 0, # admin
    password: "123456",
    password_confirmation: "123456")
  end

Housing.create!(name: "Housing Demo Uno", status: "Active", user_id: User.first.id)
Housing.create!(name: "Housing Demo Dos", status: "Active", user_id: User.second.id)

HousingUser.create!(user_id: User.first.id, housing_id: Housing.first.id)
HousingUser.create!(user_id: User.second.id, housing_id: Housing.second.id)

20.times do |i|
  Tag.create!(name: "tag-#{i+1}")
end

# crea 5 usuarios con role "Member"
5.times do |i|
  User.create!(name: "member-#{i+1}",
              email: "member-#{i+1}@email.com",
              role: 1, # member
              password: "123456",
              password_confirmation: "123456")
  HousingUser.create!(user_id: User.last.id, housing_id: Housing.first.id)
end

5.times do |u|
  user = User.last.id
  User.create!(name: "member-#{u+1}",
              email: "member-#{user+1}@email.com",
              role: 1, # member
              password: "123456",
              password_confirmation: "123456")
  HousingUser.create!(user_id: User.last.id, housing_id: Housing.last.id)
end

# ingresos, gastos y gastos compartidos para el usuario 1
30.times do |t|
  min_date = Time.now - 3.month
  max_date = Time.now - 1.month
  Transaction.create!(user_id: User.first.id,
                      description: "transaction-#{t+1}",
                      mount: rand(10000..500000),
                      date_transaction: rand(min_date..max_date),
                      type_transaction: rand(0..2),
                      housing_id: Housing.first.id,
                      tag_id: rand(1..20)
  )
end

SuperUser.create!(email: 'super@email.com', password: '123456', password_confirmation: '123456')