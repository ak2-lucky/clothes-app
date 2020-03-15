# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do
  username  = Faker::Name.name
  email = Faker::Internet.email
  sex = Faker::Gender.binary_type
  height = "160cm台"
  password = "password"
  User.create!(username:  username,
               email: email,
               sex: sex,
               height: height,
               password:              password,
               password_confirmation: password)
end

# マイクロポスト
users = User.order(:created_at).take(6)
50.times do |n|
  context = Faker::Lorem.sentence(word_count: 10)
  if n % 2 == 0
    brand = "UNIQLO"
  else
    brand = "GU"
  end
  
  if n % 3 == 0
    sex = "Mens"
  else
    sex = "Womens"
  end
  
  if n % 3 == 0
    category = "アウター"
    product_name = "デニムワークジャケット"
  elsif  n % 2 == 0
    category = "トップス"
    product_name = "スウェットプルパーカ"
  else
    category = "ボトムス"
    product_name = "スリムフィットストレートジーンズ"
  end
  
  rate = 4.5
  picture = open("db/fixtures/パーカー.jpeg")
    
  users.each { |user| user.posts.create!(
    context: context,
    brand: brand,
    sex: sex,
    category: category,
    product_name: product_name,
    rate: rate,
    picture: picture) }
end
