require 'rails_helper'

RSpec.describe "Signup", type: :request do
  describe "GET /users/sign_up" do
    let!(:testuser) { build(:user) }

    before do
      get  new_user_registration_path
    end

    it "正常なレスポンスを返すこと" do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "アカウント登録に成功したとき" do
      expect do
        post user_registration_path, params: { user: {
          username: testuser.username,
          email: testuser.email,
          sex: testuser.sex,
          height: testuser.height,
          password: testuser.password,
          password_confirmation: testuser.password_confirmation,
        } }
      end.to change(User, :count).by(1)
      expect(response).to have_http_status(302)
      expect(response.body).not_to include "error_explanation"
      expect(response).to redirect_to posts_path
    end

    it "アカウント登録に失敗したとき" do
      expect do
        post user_registration_path, params: { user: {
          username: "",
          email: "",
          sex: "",
          height: "",
          password: "",
          assword_confirmation: "",
        } }
      end.not_to change(User, :count)
      expect(response).to have_http_status(200)
      expect(response.body).to include "error_explanation"
      expect(response).to render_template 'users/registrations/new'
    end
  end
end
