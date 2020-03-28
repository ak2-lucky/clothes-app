require 'rails_helper'

RSpec.describe "Static_Pages", type: :request do
  
  describe "GET staticpages_home" do
    it "正常なレスポンスを返すこと" do
      get root_path
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end
  
  describe "GET staticpages_about" do
    it "正常なレスポンスを返すこと" do
      get about_path
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end
end