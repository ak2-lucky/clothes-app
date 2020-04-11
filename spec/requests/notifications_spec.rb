require 'rails_helper'

RSpec.describe "Notification", type: :request do
  describe "Notification" do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:post_with_user) { create(:post, user: user) }
    let!(:comment_with_other_user) { create(:comment, user: other_user, post: post_with_user) }
    let!(:notification) { create(:notification, visitor: other_user, visited: user, post: post_with_user, comment: comment_with_other_user) }

    context "index" do
      before do
        sign_in user
        get notifications_path
      end

      it "正常なレスポンスを返すこと" do
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end

      it "ページに必要な情報が表示されること" do
        expect(response.body).to include notification.visitor.username
        expect(response.body).to include notification.comment.content
      end
    end
  end
end
