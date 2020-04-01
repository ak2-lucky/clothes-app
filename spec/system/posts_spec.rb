require 'rails_helper'

RSpec.describe "Posts", type: :system do
  include ApplicationHelper
  let!(:user) { create(:user) }
  let!(:post_with_user) { create(:post, user: user) }
  let!(:other_post_with_user) { create(:post, user: user, brand: "GU",product_name: "testproduct", content: "testtext2") }

  describe "レビュー投稿" do
    context "ログインしていない場合" do
      it "ログインしていない場合はログインを要求すること" do
        visit new_post_path
        expect(page).to have_current_path new_user_session_path
        expect(page).to have_content "アカウント登録もしくはログインしてください。"
      end
    end
    
    context "ログインしている場合" do
      before do
        sign_in user
        visit new_post_path
      end
      
      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title("Post New")
      end
      
      it "有効な情報なら投稿ができること" do
        select "Mens", from: "分類"
        select "GU", from: "ブランド"
        select "トップス", from: "カテゴリー"
        fill_in "商品の名前", with: "プルオーバーパーカー"
        find('#post_star', visible: false).set(4.5)
        fill_in "レビュー内容", with: "着心地が良く肉厚で着やすかった"
        attach_file 'post_picture', Rails.root.join('spec', 'fixtures', 'sample2.jpeg')
        click_button "投稿する"
        expect(page).to have_current_path posts_path
        expect(page).to have_content "投稿が完了しました。"
      end
    end
  end
  
   describe "検索ページ" do
     context "ログインしていない場合" do
       before do 
         visit posts_path
       end
       
       it "正しいタイトルが表示されること" do
         expect(page).to have_title full_title("Post Index")
       end
      
       it "ログインしていない場合でも検索ページに到達できること" do
         expect(page).to have_current_path posts_path
       end
     end
     
     context "ログインしている場合" do
       before do 
         sign_in user
         visit posts_path
       end
       
       it "正しいタイトルが表示されること" do
         expect(page).to have_title full_title("Post Index")
       end
      
       it "ログインしている場合でも検索ページに到達できること" do
         expect(page).to have_current_path posts_path
       end
       
       it "今まで投稿されたレビューが表示されていること" do
         expect(page).to have_content user.username
         expect(page).to have_content user.sex
         expect(page).to have_content user.height
         expect(page).to have_content post_with_user.sex
         expect(page).to have_content post_with_user.brand
         expect(page).to have_content post_with_user.category
         expect(page).to have_content post_with_user.content
         #rateが表示されている事を確認する
         #expect(find('score', visible: false).value).to eq 4.5
         expect(page).to have_link "コメント", href: post_path(post_with_user)
         expect(page).to have_content other_post_with_user.sex
         expect(page).to have_content other_post_with_user.brand
         expect(page).to have_content other_post_with_user.category
         expect(page).to have_content other_post_with_user.content
       end
       
       it "検索条件の投稿が表示されていること" do
         select "UNIQLO", from: "ブランド"
         click_button "検索"
         expect(page).to have_content user.username
         expect(page).to have_content user.sex
         expect(page).to have_content user.height
         expect(page).to have_content post_with_user.sex
         expect(page).to have_content post_with_user.brand
         expect(page).to have_content post_with_user.category
         expect(page).to have_content post_with_user.content
         #rateが表示されている事を確認する
         #expect(find('score', visible: false).value).to eq 4.5
         expect(page).to have_link "コメント", href: post_path(post_with_user)
         expect(page).not_to have_content other_post_with_user.product_name
         expect(page).not_to have_content other_post_with_user.content
       end
     end
   end
   
   describe "投稿詳細ページ" do
     context "ログインしていない場合" do
       it "ログインしていない場合はログインを要求すること" do
         visit post_path(post_with_user)
         expect(page).to have_current_path new_user_session_path
         expect(page).to have_content "アカウント登録もしくはログインしてください。"
       end
     end
     
     context "ログインしている場合" do
       before do
         sign_in user
         visit post_path(post_with_user)
       end
      
       it "正しいタイトルが表示されること" do
         expect(page).to have_title full_title("Post Show")
       end
       
       it "正しいページに遷移していること" do
         expect(page).to have_current_path post_path(post_with_user)
       end
       
       it "投稿の情報が表示されていること" do
         expect(page).to have_content user.username
         expect(page).to have_content user.sex
         expect(page).to have_content user.height
         expect(page).to have_content post_with_user.sex
         expect(page).to have_content post_with_user.brand
         expect(page).to have_content post_with_user.category
         expect(page).to have_content post_with_user.content
         #rateが表示されている事,画像が確認する
         #expect(find('score', visible: false).value).to eq 4.5
       end
       
     end
   end       
end
