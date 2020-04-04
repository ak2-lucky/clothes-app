#testsampleuser
username = "testsampleuser"
email = "test@test.com"
sex = "男性"
height = "160cm台"
password = "password"
User.create!(username:  username,
               email: email,
               sex: sex,
               height: height,
               password:              password,
               password_confirmation: password)
               
user = User.find_by(username: username)

10.times do |n|
  content = Faker::Lorem.sentence(word_count: 10)
  if n % 2 == 0
    brand = "UNIQLO"
  else
    brand = "GU"
  end
  
  sex = "Mens"
  
  
  if n % 3 == 0
    category = "アウター"
    product_name = "ウールチェスターコート"
  elsif  n % 2 == 0
    category = "トップス"
    product_name = "コットンスウェットプルパーカ"
    picture = open("db/fixtures/パーカー.jpeg")
  else
    category = "ボトムス"
    product_name = "ウルトラストレッチスキニーフィットジーンズ"
  end
  
  rate = 4.5

  user.posts.create!(
    content: content,
    brand: brand,
    sex: sex,
    category: category,
    product_name: product_name,
    rate: rate,
    picture: picture) 
    
end
               
               

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

# ポスト
users = User.order(:created_at).take(6)
50.times do |n|
  content = Faker::Lorem.sentence(word_count: 10)
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
    picture = open("db/fixtures/パーカー.jpeg")
  else
    category = "ボトムス"
    product_name = "スリムフィットストレートジーンズ"
  end
  
  rate = 4.5
    
  users.each { |user| user.posts.create!(
    content: content,
    brand: brand,
    sex: sex,
    category: category,
    product_name: product_name,
    rate: rate,
    picture: picture) }
end
