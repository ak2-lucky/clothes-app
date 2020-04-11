require "rails_helper"

RSpec.describe Devise::Mailer, type: :mailer do
  describe "パスワードリセットメール" do
    let(:user) { FactoryBot.create(:user) }
    let(:email) { Devise.mailer.deliveries.last }

    before do
      user.send_reset_password_instructions
    end

    it "メールの宛先が正しいこと" do
      expect(email.to).to eq [user.email]
    end

    it "メールに送信元が正しいこと" do
      expect(email.from).to eq ["noreply@example.com"]
    end

    it "正しい件名で送信されていること" do
      expect(email.subject).to eq "パスワードの再設定について"
    end

    it "メールの本文にユーザーの名前とメールアドレスが入っていること" do
      expect(email.body).to include user.username
      expect(email.body).to include user.email
    end

    it "メールの本文にパスワード再設定のリンクがあること" do
      expect(email.body).to include edit_user_password_path
    end
  end
end
