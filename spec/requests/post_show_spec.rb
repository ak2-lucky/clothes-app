require 'rails_helper'

RSpec.describe "User_Show", type: :request do
  describe "GET /posts/show" do
    let!(:user) { create(:user) }
    let!(:post) { create(:post, user: user) }

    before do
      sign_in user
      get post_path(post.id)
    end

    it "正常なレスポンスを返すこと" do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "レスポンスにユーザーの情報が含まれていること" do
      expect(response.body).to include user.username
      expect(response.body).to include user.sex
      expect(response.body).to include user.height
    end

    it "自分の投稿が削除できること" do
      expect do
        delete post_path(post.id), headers: { "HTTP_REFERER" => "http://www.example.com/posts/#{post.id}" }
      end.to change(Post, :count).by(-1)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to post_path(post.id)
    end

    it "投稿の内容が表示されていること" do
      expect(response.body).to include post.content
      expect(response.body).to include post.sex
      expect(response.body).to include post.brand
      expect(response.body).to include post.category
    end
  end
end
