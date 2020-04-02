require 'rails_helper'


RSpec.describe "Users", type: :system do
  include ApplicationHelper
  let!(:user) { create(:user) }
  let!(:post_with_user) { create(:post, user: user) }

  
  describe "ユーザー登録" do
    before do
      visit new_user_registration_path
    end
    
    it "正しいタイトルが表示されること" do
      expect(page).to have_title full_title("Sign up")
    end
    
    
    it "有効な情報ならユーザー登録できること" do
      fill_in "ユーザーネーム", with: "testuser1"
      fill_in "メールアドレス", with: "test1@example.com"
      select "男性", from: "性別"
      select "150cm台", from: "身長"
      fill_in "パスワード", with: "testpassword"
      fill_in "確認用パスワード", with: "testpassword"
      click_button "アカウント登録"
      expect(page).to have_content "アカウント登録が完了しました。"
      expect(page).to have_current_path posts_path
    end
    
    it "無効な情報ならユーザー登録ができずエラーメッセージが表示されること" do
      fill_in "ユーザーネーム", with: ""
      fill_in "メールアドレス", with: ""
      select "男性", from: "性別"
      select "150cm台", from: "身長"
      fill_in "パスワード", with: ""
      fill_in "確認用パスワード", with: ""
      click_button "アカウント登録"
      expect(page).not_to have_content "アカウント登録が完了しました。"
      expect(page).to have_content "ユーザーネームが入力されていません。"
      expect(page).to have_content "メールアドレスが入力されていません。"
      expect(page).to have_content "パスワードが入力されていません。"
    end
  end
  
  describe "ユーザーログイン" do
    before do
      visit new_user_session_path
    end
    
    it "表示されているリンクが正しいこと" do
      click_link "アカウント登録" 
      expect(page).to have_current_path new_user_registration_path
    end
    
     it "表示されているリンクが正しいこと" do
      click_link "パスワードを忘れた方はこちらへ" 
      expect(page).to have_current_path new_user_password_path
    end
 
    it "正しいタイトルが表示されること" do
      expect(page).to have_title full_title("Login")
    end
    
    it "有効な情報ならログインできること" do
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_button "ログイン"
      expect(page).to have_content "ログインしました。"
      expect(page).to have_current_path posts_path
    end
    
    it "無効な情報ならログインができずエラーメッセージが表示されること" do
      fill_in "メールアドレス", with: ""
      fill_in "パスワード", with: ""
      click_button "ログイン"
      expect(page).not_to have_content "ログインしました。"
      expect(page).to have_content "メールアドレスまたはパスワードが違います。"
    end
  end
  
  describe "ログアウト" do
    before do
      sign_in user
      visit posts_path
    end
    
    it "表示されているリンクが正しいこと" do
      click_link "LOG OUT" 
      expect(page).to have_content "ログアウトしました。"
      expect(page).to have_current_path root_path
    end
  end
  
  describe "ユーザー情報表示" do
    before do
      sign_in user
      visit user_path(user)
    end
    
    it "正しいタイトルが表示されていること" do
      expect(page).to have_title full_title("User")
    end
    
    it "ユーザーの情報と編集へのリンクが表示されていること" do
      within ".user_info" do
        expect(page).to have_current_path user_path(user)
        expect(page).to have_content user.username
        expect(page).to have_content user.sex
        expect(page).to have_content user.height
        expect(page).to have_link "プロフィール編集", href: edit_user_registration_path
      end
    end
    
    it "ユーザーが投稿したレビューの情報が表示されていること" do
      within ".post_feed" do
        expect(page).to have_content user.username
        expect(page).to have_content user.sex
        expect(page).to have_content user.height
        expect(page).to have_content post_with_user.category
        expect(page).to have_content post_with_user.brand
        expect(page).to have_content post_with_user.sex
        expect(page).to have_content post_with_user.content
        expect(page).to have_content post_with_user.product_name
        expect(page).to have_link "投稿削除", href: post_path(post_with_user)
        expect(page).not_to have_link "コメント", href: post_path(post_with_user)
      end
      #画像投稿のテスト
    end
  end
    
  describe "ユーザー情報編集" do
    before do
      sign_in user
      visit user_path(user)
      click_link "プロフィール編集"
    end
      
    it "正しいタイトルが表示されていること" do
      expect(page).to have_title full_title("User Edit")
    end
    
    it "正しくページ遷移ができていること" do
      expect(page).to have_current_path edit_user_registration_path
    end
    
    it "リンクが正しいこと" do
      click_link "戻る"
      expect(page).to have_current_path user_path(user)
    end
    
    it "ボタンが正しいこと" do
      click_button "アカウント削除"
      expect(page).to have_content "アカウントを削除しました。またのご利用をお待ちしております。"
      expect(page).to have_current_path root_path
    end
    
    it "有効な情報なら変更できること(パスワードは空白でもOK)" do
      fill_in "ユーザーネーム", with: "testusername2"
      fill_in "メールアドレス", with: "test2@test2.com"
      fill_in "パスワード", with: ""
      fill_in "確認用パスワード", with: ""
      fill_in "現在のパスワード", with: user.password
      click_button "情報を更新する"
      expect(page).to have_content "アカウント情報を変更しました。"
      expect(page).to have_current_path posts_path
    end
    
    it "無効な情報では変更できないこと" do
      fill_in "ユーザーネーム", with: ""
      fill_in "メールアドレス", with: ""
      fill_in "パスワード", with: ""
      fill_in "確認用パスワード", with: ""
      fill_in "現在のパスワード", with: ""
      click_button "情報を更新する"
      expect(page).not_to have_content "アカウント情報を変更しました。"
      expect(page).to have_content "現在のパスワードを入力してください"
      expect(page).to have_content "ユーザーネームが入力されていません。"
      expect(page).to have_content "メールアドレスが入力されていません。"
    end
  end
  
  describe "パスワードリセット" do
    before do
      visit new_user_session_path
      click_link "パスワードを忘れた方はこちらへ"
    end
    
    it "正しいタイトルが表示されていること" do
      expect(page).to have_title full_title("Password Reset")
    end
    
    it "表示されているリンクが正しいこと" do
      expect(page).to have_link "ログイン", href: new_user_session_path
      expect(page).to have_link "アカウント登録", href: new_user_registration_path
    end
    
    #メール送信のテストをあとで追加
    #it "メールが適切に送られていること" do
    #  expect(page).to have_current_path new_user_password_path
    #  
    # end
  end
  
end