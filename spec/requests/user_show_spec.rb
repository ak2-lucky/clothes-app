require 'rails_helper'

RSpec.describe "User_Show", type: :request do
  
  describe "GET /users/show" do
    let!(:user) { create(:user) }
    let!(:post) { create(:post, user: user) }
    before do
      sign_in user
      get  user_path(user.id)
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
    
    it "投稿があれば表示されていること" do
       expect(response.body).to include post.content
       expect(response.body).to include post.sex
       expect(response.body).to include post.brand
       expect(response.body).to include post.category
    end
  end
end