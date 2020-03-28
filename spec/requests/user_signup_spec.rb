require 'rails_helper'

RSpec.describe "Signup", type: :request do
  
  describe "GET /users/sign_up" do
    let(:user) { build(:user) }
    
    before do
      get  new_user_registration_path
    end
    
      it "正常なレスポンスを返すこと" do
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
      
      it "アカウント登録に成功したとき" do
        expect{
          post user_registration_path, params: { user: { username:  "testuser",
                                         email: "testuser@test.com",
                                         sex: user.sex,
                                         height: user.height,
                                         password:              user.password,
                                         password_confirmation: user.password_confirmation } }
        }.to change(User, :count).by(1)
        expect(response).to have_http_status(302)
        expect(response.body).not_to include "error_explanation"
        expect(response).to redirect_to posts_path
      end
      
      it "アカウント登録に失敗したとき" do
        expect{
        post user_registration_path, params: { user: { username: "", 
                                          email: "",
                                          sex: "",
                                          height: "",
                                          password: ""} }
         }.not_to change(User, :count)                                  
        expect(response).to have_http_status(200)
        expect(response.body).to include "error_explanation"
        expect(response).to render_template 'users/registrations/new'
      end
    end
end