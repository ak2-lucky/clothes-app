require 'rails_helper'

RSpec.describe "User_Edit", type: :request do
  
  describe "GET /users/edit" do
    let!(:user) { create(:user) }
    
    
    
    context "ログインしている場合" do
      before do
        sign_in user
        get  edit_user_registration_path
      end
      
      it "正常なレスポンスを返すこと" do
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
      
      it "パスワードを変更しない場合でも情報を更新できること" do
        patch user_registration_path, params: { user: { username:  "testuser2",
                                         email: "testemail@test.com",
                                         sex: user.sex,
                                         height: user.height,
                                         password:              "",
                                         password_confirmation: "",
                                         current_password: user.password} }
        expect(response).to have_http_status(302)
        expect(response.body).not_to include "error_explanation"
        expect(response).to redirect_to posts_path
      end
      
      it "パスワードを変更する場合でも情報を更新できること" do
        patch user_registration_path, params: { user: { username:  "testuser3",
                                         email: "testemail2@test.com",
                                         sex: user.sex,
                                         height: user.height,
                                         password:              "asasas",
                                         password_confirmation: "asasas",
                                         current_password: user.password} }
        expect(response).to have_http_status(302)
        expect(response.body).not_to include "error_explanation"
        expect(response).to redirect_to posts_path
      end
      
      it "情報が更新できなかった場合元のページに戻ること" do
        patch user_registration_path, params: { user: { username:  "",
                                         email: "",
                                         sex: "",
                                         height: "",
                                         password:              "",
                                         password_confirmation: "",
                                         current_password: ""} }
        expect(response).to have_http_status(200)
        expect(response.body).to include "error_explanation"
        expect(response).to render_template 'users/registrations/edit'
      end
      
      it "アカウントが削除できること" do
        delete user_registration_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to root_path
      end  
    end
    
    context "ログインしていない場合" do
      it "リダイレクトされること" do
        get  edit_user_registration_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end