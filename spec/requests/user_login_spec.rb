require 'rails_helper'

RSpec.describe "Login&Logout", type: :request do
  describe "GET /users/sign_in" do
    let!(:user) { create(:user) }

    before do
      get  new_user_session_path
    end

    context "ログインしていない場合" do
      it "正常なレスポンスを返すこと" do
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end

      it "ログインに成功したとき" do
        post user_session_path, params: { session: {
          email: user.email,
          password: user.password,
        } }
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end

      it "ログインに失敗したとき" do
        post user_session_path, params: { session: {
          email: "",
          password: "",
        } }
        expect(response).to have_http_status(200)
        expect(flash[:alert]).to be_truthy
        expect(response).to render_template 'users/sessions/new'
      end
    end

    context "ログインしている場合" do
      it "投稿一覧ページにリダイレクトされること" do
        sign_in user
        expect(response).to be_successful
        expect(response).to have_http_status(200)
        get new_user_session_path
        expect(response).to redirect_to posts_path
      end

      it "ログアウトできること" do
        sign_in user
        expect(response).to be_successful
        expect(response).to have_http_status(200)
        delete destroy_user_session_path
        expect(response).to redirect_to root_path
      end
    end
  end
end
