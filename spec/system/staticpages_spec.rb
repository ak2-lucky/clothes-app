require 'rails_helper'

RSpec.describe "Staticpages", type: :system do
  include ApplicationHelper
  let!(:user) { create(:user) }

  describe "Home" do
    context "ログインしていない場合" do
      before do
        visit root_path
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title("Home")
      end

      it "正しいページに遷移していること" do
        expect(page).to have_current_path root_path
      end

      it "ヘッダーのリンクが正しいこと" do
        expect(page).to have_link "HOME", href: root_path
        expect(page).to have_link "ABOUT", href: about_path
        expect(page).to have_link "SEARCH", href: posts_path
        expect(page).to have_link "LOG IN", href: new_user_session_path
      end

      it "ボタンの遷移先が正しいこと" do
        click_link "Sign Up"
        expect(page).to have_current_path new_user_registration_path
      end
    end

    context "ログインしている場合" do
      before do
        sign_in user
        visit root_path
      end

      it "検索ページにリダイレクトされていること" do
        expect(page).to have_current_path posts_path
      end

      it "ヘッダーのリンクが正しいこと" do
        expect(page).to have_link "NOTICE", href: notifications_path
        expect(page).to have_link "SEARCH", href: posts_path
        expect(page).to have_link "MYPAGE", href: user_path(user)
        expect(page).to have_link "NEW POST", href: new_post_path
        expect(page).to have_link "LOG OUT", href: destroy_user_session_path
      end
    end
  end

  describe "About" do
    context "ログインしていない場合" do
      before do
        visit about_path
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title("About")
      end

      it "正しいページに遷移していること" do
        expect(page).to have_current_path about_path
      end
    end

    context "ログインしている場合" do
      before do
        sign_in user
        visit about_path
      end

      it "検索ページにリダイレクトされていること" do
        expect(page).to have_current_path posts_path
      end
    end
  end
end
