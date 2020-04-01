require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  
  context "カラムのバリデーション" do
    it "ユーザーネーム、メールアドレス、身長、性別、パスワード,確認用パスワードがあれば有効であること" do
      expect(user).to be_valid
    end
    
    it "ユーザーネームがなければ無効な状態であること" do
      user = build(:user, username: nil)
      user.valid?
      expect(user.errors[:username]).to include("が入力されていません。")
    end
    
    it "ユーザーネームが50文字以内であること" do
      user = build(:user, username: "a" * 51)
      user.valid?
      expect(user.errors[:username]).to include("は50文字以下に設定して下さい。")
    end
    
    it "ユーザーネームは一意的であること" do
      other_user = build(:user, username: user.username)
      other_user.valid?
      expect(other_user.errors[:username]).to include("は既に使用されています。")
    end
    
    it "メールアドレスがなければ無効な状態であること" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("が入力されていません。")
    end
    
    it "メールアドレスには＠が必要であること" do
      user = build(:user, email: "a" * 5)
      user.valid?
      expect(user.errors[:email]).to include("は有効でありません。")
    end
    
    it "メールアドレスは一意的であること" do
      other_user = build(:user, email: user.email)
      other_user.valid?
      expect(other_user.errors[:email]).to include("は既に使用されています。")
    end
    
    it "メールアドレスは小文字で保存されること" do
      email = "testmail@example.com"
      user = create(:user, email: email)
      expect(user.email).to eq email.downcase
    end
    
    it "身長がなければ無効な状態であること" do
      user = build(:user, height: nil)
      user.valid?
      expect(user.errors[:height]).to include("が選択されていません。")
    end
    
    it "性別がなければ無効な状態であること" do
      user = build(:user, sex: nil)
      user.valid?
      expect(user.errors[:sex]).to include("が選択されていません。")
    end
    
    it "パスワードがなければ無効な状態であること" do
      user = build(:user, password: nil, password_confirmation: nil)
      user.valid?
      expect(user.errors[:password]).to include("が入力されていません。")
    end
    
    it "パスワードは5文字以下では無効であること" do
      user = build(:user, password: "a"*5)
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上に設定して下さい。")
    end 
    
    it "パスワードは129文字以上では無効であること" do
      user = build(:user, password: "a"*129)
      user.valid?
      expect(user.errors[:password]).to include("は128文字以下に設定して下さい。")
    end
    
    it "パスワードと確認用パスワードは一致していること" do
      user = build(:user, password: "a" * 10, password_confirmation: "a" * 9)
      user.valid?
      expect(user.errors[:password_confirmation]).to include("がパスワードと一致していません。")
    end
    
  end
end
