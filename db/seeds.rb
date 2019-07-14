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

User.create!(name:  "工藤わらび(創作漫画)@warabikudo",
             email: "twitter1@gmail.com",
             password:              "foobar",
             password_confirmation: "foobar")

User.create!(name:  "竹村洋平@takemura4hey",
             email: "twitter2@gmail.com",
             password:              "foobar",
             password_confirmation: "foobar")

2.times do |n|
  name  = Faker::Name.name
  email = "test-#{n+1}@gmail.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at)
2.times do
  title = Faker::Book.title
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.books.create!(content: content, title: title, picture: open("#{Rails.root}/db/fixtures/f19d591e40ae09ccbb5c64110cdcf92a.jpg")) }
end

books = Book.order(:created_at)
1.times do |n|
  books.each { |book| book.volumes.create!(
               title: "これは本の話数のタイトルです",
               content: "It was very good. We will support you from now on, so please do your best.",
               ) }
end

volumes = Volume.order(:created_at)
1.times do |n|
  volumes.each { |volume| 
               volume.pictures.create!(
                 picture: open("#{Rails.root}/db/fixtures/D-mX7cmUIAc7H-h.jpg")
                 )
               volume.pictures.create!(
                 picture: open("#{Rails.root}/db/fixtures/D-mX7e4UYAA4969.jpg")
                 )
               volume.pictures.create!(
                 picture: open("#{Rails.root}/db/fixtures/D-mYCMXVUAE_4EX.jpg")
                 )
  }
end

books = Book.order(:created_at)
3.times do |n|
  books.each { |book| book.evaluations.create!(
               comment: "It was very good. We will support you from now on, so please do your best.",
               user_id: n+1,
               star: rand(1..5)) }
end