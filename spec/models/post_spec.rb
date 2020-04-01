require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:post) { create(:post) }
  let(:image_path) { File.join(Rails.root, 'spec/fixtures/sample1.jpg') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }
  
  context "カラムのバリデーション" do
    it "関連付けしているユーザーの情報、評価レビュー、ブランド、カテゴリー、性別、評価があれば有効であること" do
      expect(post).to be_valid
    end
     
    it "関連付けしているユーザーの情報がなければ無効な状態であること" do
      post = build(:post, user_id: nil)
      post.valid?
      expect(post.errors[:user_id]).to include("が入力されていません。")
    end
    
    it "投稿内容がなければ無効な状態であること" do
      post = build(:post, content: nil)
      post.valid?
      expect(post.errors[:content]).to include("が入力されていません。")
    end
    
    it "投稿内容が300文字以内であること" do
      post = build(:post, content: "a" * 301)
      post.valid?
      expect(post.errors[:content]).to include("は300文字以下に設定して下さい。")
    end 
    
    it "ブランドがなければ無効な状態であること" do
      post = build(:post, brand: nil)
      post.valid?
      expect(post.errors[:brand]).to include("が選択されていません。")
    end
    
    it "カテゴリーがなければ無効な状態であること" do
      post = build(:post, category: nil)
      post.valid?
      expect(post.errors[:category]).to include("が選択されていません。")
    end
    
    it "評価がなければ無効な状態であること" do
      post = build(:post, rate: nil)
      post.valid?
      expect(post.errors[:rate]).to include("が入力されていません。")
    end
    
    it "カテゴリーがなければ無効な状態であること" do
      post = build(:post, sex: nil)
      post.valid?
      expect(post.errors[:sex]).to include("が選択されていません。")
    end
    
    it "商品の名前がなければ無効な状態であること" do
      post = build(:post, product_name: nil)
      post.valid?
      expect(post.errors[:product_name]).to include("が入力されていません。")
    end
    
    it "ファイルの種類はjpegかpngであること" do
      post = build(:post, picture: image)
      post.valid?
      expect(post.errors[:picture]).to include("\"jpg\"ファイルのアップロードは許可されていません。アップロードできるファイルタイプ: jpeg, png")
    end
    
  end
  
  
end
