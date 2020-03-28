require 'rails_helper'

RSpec.describe "Post_new", type: :request do
  
  describe "GET /posts/new" do
    let!(:user) { create(:user) }
    
    before do
      sign_in user
      get  new_post_path
    end
    
    it "正常なレスポンスを返すこと" do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
      
    it "投稿に成功した場合検索ページに飛んでいること" do
      expect{
        post posts_path, params: { post: { sex:  "男性",
                                       brand: "UNIQLO",
                                       category: "アウター",
                                       product_name: "感動パンツ",
                                       rate: 4.5,
                                       content: "最高" } }
      }.to change(Post, :count).by(1)
      expect(response).to have_http_status(302)
      expect(response.body).not_to include "error_explanation"
      expect(response).to redirect_to posts_path
    end
      
    it "投稿に失敗した場合同じページに戻りエラーメッセージが出ていること" do
      expect{
        post posts_path, params: { post: { sex:  "",
                                       brand: "",
                                       category: "",
                                       product_name: "",
                                       rate: "",
                                       content: "" } }
       }.not_to change(Post, :count)                                  
      expect(response).to have_http_status(200)
      expect(response.body).to include "error_explanation"
      expect(response).to render_template 'posts/new'
    end
    
    
  end
end