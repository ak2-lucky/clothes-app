require 'rails_helper'

RSpec.describe "Posts", type: :system do
  include ApplicationHelper
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:post_with_user) { create(:post, user: user) }
  let!(:comment_with_user) { create(:comment, post: post_with_user,  user: user) }
  
  describe "コメント投稿,コメント削除" do
    before do
      sign_in other_user
      visit posts_path
      click_link "コメント"
    end
    
    it "有効な情報ならコメントが投稿できて削除ができること", js: true do
      expect(page).to have_current_path post_path(post_with_user)
      fill_in "comment-textarea", with: "testcomment"
      click_button "コメントをする"
      expect(page).not_to have_content "コメントが入力されていません。"
      expect(page).to have_content "testcomment"
    end
    
    it "無効な情報ならコメントが投稿できずエラーメッセージが出ること", js: true do
      expect(page).to have_current_path post_path(post_with_user)
      fill_in "comment-textarea", with: ""
      click_button "コメントをする"
      expect(page).to have_content "コメントが入力されていません。"
    end
    
    it "自分のコメントだけ削除できること", js: true do
      expect(page).to have_content comment_with_user.content
      fill_in "comment-textarea", with: "testcomment"
      click_button "コメントをする"
      expect(page).to have_content "testcomment"
      within all(:css, ".comment")[0] do
        expect(page).not_to have_link "コメントを削除する"
      end
      within all(:css, ".comment")[1] do
        expect(page).to have_link "コメントを削除する"
        click_link "コメントを削除する"
      end
      expect(page).not_to have_content "testcomment"
      expect(page).to have_content comment_with_user.content
    end
  end
end