require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:comment) { create(:comment) }
  
  
  context "カラムのバリデーション" do
    it "関連付けしているユーザーの情報、関連している投稿の情報,コメントがあれば有効であること" do
      expect(comment).to be_valid
    end
    
    it "関連付けしているユーザーの情報がなければ無効な状態であること" do
      comment = build(:comment, user_id: nil)
      comment.valid?
      expect(comment.errors[:user_id]).to include("が入力されていません。")
    end
    
    it "関連している投稿の情報がなければ無効な状態であること" do
      comment = build(:comment, post_id: nil)
      comment.valid?
      expect(comment.errors[:post_id]).to include("が入力されていません。")
    end
    
    it "コメントがなければ無効な状態であること" do
      comment = build(:comment, content: nil)
      comment.valid?
      expect(comment.errors[:content]).to include("が入力されていません。")
    end
    
    it "投稿内容が300文字以内であること" do
      comment = build(:comment, content: "a" * 301)
      comment.valid?
      expect(comment.errors[:content]).to include("は300文字以下に設定して下さい。")
    end 
  end
end
