#testsampleuser
User.create!(
  [
    {
      username:  "testsampleuser",
      email: "test@test.com",
      sex: "男性",
      height: "160cm台",
      password: "password",
      password_confirmation: "password"
    },
    {
      username:  "testscommentuser",
      email: "test@example.com",
      sex: "女性",
      height: "160cm台",
      password: "password2",
      password_confirmation: "password2"
    }
  ]
)
               
               
user1 = User.find(1)
user2 = User.find(2)

10.times do |n|
  if n % 2 == 0
    brand = "UNIQLO"
  else
    brand = "GU"
  end
  
  sex = "Mens"
  
  if n % 5 == 0
    category = "シューズ"
    product_name = "ニットスニーカー"
    rate = 4.5
    content = "履き心地がとても良い。シンプルで使いやすい上にデザインも悪くない。値段以上の価値はあると思う。"
  elsif n % 4 == 0
    category = "アクセサリー"
    product_name = "シンプルフープピアス"
    rate = 4.0
    content = "シンプルなデザインなのでどんなコーディネートにも合うと思う。高級感も少しあり、プチプラには見えづらい。"
  elsif n % 3 == 0
    category = "アウター"
    product_name = "デニムワークジャケット"
    rate = 3.0
    content = "アームの部分がかなり細くタイトに作られている。腕が太い人や肩幅が広い人は普段のワンサイズ大きめを注文した方が良いかもしれない。"
  elsif  n % 2 == 0
    category = "トップス"
    product_name = "スウェットプルパーカ"
    content = "素材自体が肉厚であるため、夏以外は使える。フードの立ちも良いので安く見えにくい。主張は少ないが、他のアイテムと合わせやすく、使い回ししやすい。"
    picture = open("db/fixtures/パーカー.jpeg")
    rate = 4.0
  else
    category = "ボトムス"
    product_name = "ウルトラストレッチスキニージーンズ"
    content = "ストレッチがかなり効くので履いていてストレスがない。しかし、小さいサイズを選びすぎるとタイツを履いてるように見えるので注意が必要である。普段着としてははなり使えそう。"
    rate = 3.5
  end

  user1.posts.create!(
    content: content,
    brand: brand,
    sex: sex,
    category: category,
    product_name: product_name,
    rate: rate,
    picture: picture) 
end

post1 = Post.find(1)
post1.comments.create!(
  content: "使用してからどれくらい立ちましたか？",
  user_id: user2.id)
comment1 = Comment.find(1)

Notification.create!(
  checked: false,
  visitor_id: user2.id,
  visited_id: user1.id,
  post_id: post1.id,
  comment_id: comment1.id
  )
  
20.times do
  username  = Faker::Name.name
  email = Faker::Internet.email
  sex = Faker::Gender.binary_type
  height = "160cm台"
  password = "password3"
  User.create!(username:  username,
               email: email,
               sex: sex,
               height: height,
               password:              password,
               password_confirmation: password)
end

# 投稿
users = User.order(:created_at).take(5)
15.times do |n|
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
  
  if n % 5 == 0
    category = "シューズ"
    product_name = "ニットスニーカー"
    rate = 4.5
    content = "履き心地がとても良い。シンプルで使いやすい上にデザインも悪くない。値段以上の価値はあると思う。"
  elsif n % 4 == 0
    category = "アクセサリー"
    product_name = "シンプルフープピアス"
    rate = 4.0
    content = "シンプルなデザインなのでどんなコーディネートにも合うと思う。高級感も少しあり、プチプラには見えづらい。"
  elsif n % 3 == 0
    category = "アウター"
    product_name = "デニムワークジャケット"
    rate = 3.0
    content = "アームの部分がかなり細くタイトに作られている。腕が太い人や肩幅が広い人は普段のワンサイズ大きめを注文した方が良いかもしれない。"
  elsif  n % 2 == 0
    category = "トップス"
    product_name = "スウェットプルパーカ"
    content = "素材自体が肉厚であるため、夏以外は使える。フードの立ちも良いので安く見えにくい。主張は少ないが、他のアイテムと合わせやすく、使い回ししやすい。"
    picture = open("db/fixtures/パーカー.jpeg")
    rate = 4.0
  else
    category = "ボトムス"
    product_name = "ウルトラストレッチスキニージーンズ"
    content = "ストレッチがかなり効くので履いていてストレスがない。しかし、小さいサイズを選びすぎるとタイツを履いてるように見えるので注意が必要である。普段着としてははなり使えそう。"
    rate = 3.5
  end
  
    
  users.each { |user| user.posts.create!(
    content: content,
    brand: brand,
    sex: sex,
    category: category,
    product_name: product_name,
    rate: rate,
    picture: picture) }
end
