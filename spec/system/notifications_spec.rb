require 'rails_helper'

RSpec.describe "Notifications", type: :system do
  include ApplicationHelper
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:post_with_user) { create(:post, user: user) }
  let!(:comment_with_other_user) { create(:comment, user: other_user, post: post_with_user) }
  let!(:comment_with_user) { create(:comment, user: user, post: post_with_user, content: "testcomment2") }
  let!(:notification) { create(:notification, visitor: other_user, visited: user, post: post_with_user, comment: comment_with_other_user) }
  let!(:myself_notification) { create(:notification, visitor: user, visited: user, post: post_with_user, comment: comment_with_user) }
  
  describe "通知一覧" do
    before do
      sign_in user
      visit notifications_path
    end
    
    it "正しいタイトルが表示されていること" do
      expect(page).to have_title full_title("Notifications")
    end
    
    it "ユーザーのリンクが正しいこと" do
      click_link notification.visitor.username
      expect(page).to have_current_path user_path(notification.visitor.id)
    end
    
    it "投稿のリンクが正しいこと" do
      click_link "あなたの投稿"
      expect(page).to have_current_path  post_path(notification.post_id)
    end
    
    it "コメントに関する情報が通知のページに表示されていること" do
      expect(page).to have_current_path notifications_path
      expect(page).to have_link  notification.visitor.username, href: user_path(notification.visitor_id)
      expect(page).to have_content notification.visitor.username
      expect(page).to have_link  "あなたの投稿",  href: post_path(notification.post_id)
      expect(page).to have_content notification.comment.content
    end
    
    it "自分への通知は表示されていないこと" do
      expect(page).not_to have_content myself_notification.visitor.username
      expect(page).not_to have_content myself_notification.comment.content
    end
    
  end
end

