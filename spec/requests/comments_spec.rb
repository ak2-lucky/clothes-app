require 'rails_helper'

RSpec.describe "Comment", type: :request do
  describe "Comment" do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:post_with_user) { create(:post, user: user) }
    let!(:comment_with_user) { create(:comment, user: user, post: post_with_user) }

    context "create" do
      before do
        sign_in other_user
        get post_path(post_with_user.id)
      end

      it "正常なレスポンスを返すこと" do
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end

      it "コメント投稿に成功した場合indexページが表示されること" do
        expect do
          post post_comments_path(post_id: post_with_user.id), xhr: true,  params: { post_id: post_with_user.id, comment: { content: "testcontent" } }
        end.to change(Comment, :count).by(1)
        expect(response).to have_http_status(200)
        expect(response).to render_template 'comments/index'
      end

      it "コメント投稿に失敗した場合ajaxでエラーメッセージが出ていること" do
        expect do
          post post_comments_path(post_id: post_with_user.id), xhr: true,  params: { post_id: post_with_user.id, comment: { content: "" } }
        end.not_to change(Comment, :count)
        expect(response).to have_http_status(422)
        expect(response.body).to include "コメントが入力されていません。"
        expect(response).to render_template 'ajax_errors/error'
      end
    end

    context "delete" do
      before do
        sign_in user
        get post_path(post_with_user.id)
      end

      it "自分のコメントを削除できること" do
        expect do
          delete post_comment_path(comment_with_user.id), xhr: true
        end.to change(Comment, :count).by(-1)
        expect(response).to have_http_status(200)
        expect(response).to render_template 'comments/index'
      end
    end
  end
end
