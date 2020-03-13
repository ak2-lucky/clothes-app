require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:post) { create(:post) }
  
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
      post = build(:post, context: nil)
      post.valid?
      expect(post.errors[:context]).to include("が入力されていません。")
    end
    
    it "投稿内容が140文字以内であること" do
      post = build(:post, context: "a" * 141)
      post.valid?
      expect(post.errors[:context]).to include("は140文字以下に設定して下さい。")
    end 
    
    it "ブランドがなければ無効な状態であること" do
      post = build(:post, brand: nil)
      post.valid?
      expect(post.errors[:brand]).to include("が入力されていません。")
    end
    
    it "カテゴリーがなければ無効な状態であること" do
      post = build(:post, category: nil)
      post.valid?
      expect(post.errors[:category]).to include("が入力されていません。")
    end
    
    it "評価がなければ無効な状態であること" do
      post = build(:post, rate: nil)
      post.valid?
      expect(post.errors[:rate]).to include("が入力されていません。")
    end
    
    it "カテゴリーがなければ無効な状態であること" do
      post = build(:post, sex: nil)
      post.valid?
      expect(post.errors[:sex]).to include("が入力されていません。")
    end
    
  end
  
  
end
