require 'rails_helper'

RSpec.describe "Post_Index", type: :request do
  
  describe "GET /posts/index" do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user, sex: "女性", height: "140cm台") }
    let!(:post_with_user) { create(:post, user: user) }
    let!(:another_post_with_other_user) { create(:post, user: other_user, brand: "GU") }
    
    
    before do
      sign_in user
      get posts_path
    end
    
    it "正常なレスポンスを返すこと" do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
      
    it "検索していない時は全ての投稿の情報が表示されていること" do
      expect(response.body).to include post_with_user.category
      expect(response.body).to include post_with_user.brand
      expect(response.body).to include post_with_user.sex 
      expect(response.body).to include post_with_user.content
      expect(response.body).to include another_post_with_other_user.category
      expect(response.body).to include another_post_with_other_user.brand
      expect(response.body).to include another_post_with_other_user.sex 
      expect(response.body).to include another_post_with_other_user.content
    end
    
    it "投稿者の情報も表示されていること" do
      expect(response.body).to include user.username
      expect(response.body).to include user.sex
      expect(response.body).to include user.height
      expect(response.body).to include other_user.username
      expect(response.body).to include other_user.sex
      expect(response.body).to include other_user.height
    end
    
    it "自分の投稿が削除できること" do
      expect(response.body).to include "投稿削除"
      expect{
        delete post_path(post_with_user.id), headers: { "HTTP_REFERER" => "http://www.example.com/posts" }
        }.to change(Post, :count).by(-1)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to posts_path
    end
    
    it "検索条件通りの投稿が表示されていること" do
      get posts_path, params: { q: { sex_eq:  "",
                                       brand_eq: "UNIQLO",
                                       category_eq: "",
                                        } }
      expect(response).to have_http_status(200)
      expect(response.body).to include user.username
      expect(response.body).to include user.sex
      expect(response.body).to include user.height
      expect(response.body).to include post_with_user.category
      expect(response.body).to include post_with_user.brand
      expect(response.body).to include post_with_user.sex 
      expect(response.body).to include post_with_user.content
      expect(response.body).not_to include other_user.username
      expect(response.body).not_to include other_user.sex
      expect(response.body).not_to include other_user.height
    end
    
  end
end