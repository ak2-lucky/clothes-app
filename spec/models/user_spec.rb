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
      expect(user.errors[:username]).to include("can't be blank")
    end
    
    it "ユーザーネームが50文字以内であること" do
      user = build(:user, username: "a" * 51)
      user.valid?
      expect(user.errors[:username]).to include("is too long (maximum is 50 characters)")
    end
    
    it "ユーザーネームは一意的であること" do
      other_user = build(:user, username: user.username)
      other_user.valid?
      expect(other_user.errors[:username]).to include("has already been taken")
    end
    
    it "メールアドレスがなければ無効な状態であること" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end
    
    it "メールアドレスには＠が必要であること" do
      user = build(:user, email: "a" * 5)
      user.valid?
      expect(user.errors[:email]).to include("is invalid")
    end
    
    it "メールアドレスは一意的であること" do
      other_user = build(:user, email: user.email)
      other_user.valid?
      expect(other_user.errors[:email]).to include("has already been taken")
    end
    
    it "メールアドレスは小文字で保存されること" do
      email = "testmail@example.com"
      user = create(:user, email: email)
      expect(user.email).to eq email.downcase
    end
    
    it "身長がなければ無効な状態であること" do
      user = build(:user, height: nil)
      user.valid?
      expect(user.errors[:height]).to include("can't be blank")
    end
    
    it "性別がなければ無効な状態であること" do
      user = build(:user, sex: nil)
      user.valid?
      expect(user.errors[:sex]).to include("can't be blank")
    end
    
    it "パスワードがなければ無効な状態であること" do
      user = build(:user, password: nil, password_confirmation: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end
    
    it "パスワードは6文字以上128文字以下であること" do
      user = build(:user, password: "a"*10)
      expect(user).to be_valid
    end 
    
    it "パスワードは5文字以下では無効であること" do
      user = build(:user, password: "a"*5)
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end 
    
    it "パスワードは129文字以上では無効であること" do
      user = build(:user, password: "a"*129)
      user.valid?
      expect(user.errors[:password]).to include("is too long (maximum is 128 characters)")
    end
    
    it "パスワードと確認用パスワードは一致していること" do
      user = build(:user, password: "a" * 10, password_confirmation: "a" * 9)
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
    
  end
end
