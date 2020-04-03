require 'rails_helper'

RSpec.describe Notification, type: :model do
  let!(:notification) { create(:notification) }
  
  
  context "カラムのバリデーション" do
    it "関連付けしているユーザーの情報、関連している投稿の情報,コメントがあれば有効であること" do
      expect(notification).to be_valid
    end
    
    it "関連付けしている通知を送ったユーザーの情報がなければ無効な状態であること" do
      notification.visitor_id = nil
      expect(notification).not_to be_valid
    end
    
    it "関連付けしている通知を受けたユーザーの情報がなければ無効な状態であること" do
      notification.visited_id = nil
      expect(notification).not_to be_valid
    end
    
    it "通知された投稿の情報がなければ無効な状態であること" do
      notification.post_id = nil
      expect(notification).not_to be_valid
    end
    
    it "投稿へのコメントの情報がなければ無効な状態であること" do
      notification.comment_id = nil
      expect(notification).not_to be_valid
    end 
  end
end
