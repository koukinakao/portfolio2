# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "admin User",
             email: "test@gmail.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

3.times do |n|
  name  = Faker::Name.name
  email = "test-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at)
5.times do
  title = Faker::Book.title
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.books.create!(content: content, title: title) }
end

books = Book.order(:created_at)
5.times do
  title = Faker::Book.title
  content = Faker::Lorem.sentence(5)
  books.each { |book| book.volumes.create!(content: content, title: title) }
end