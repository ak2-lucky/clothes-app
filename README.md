# アプリケーションの概要
* 洋服(ブランドはUNIQLO,GUのみ)をレビューして投稿し、共有できるレビュー投稿サービス 

# 技術的ポイント
* ・独自ドメイン取得、使用
* ・RSpecでのテスト記述
* ・Ajaxを用いた非同期処理（コメント投稿、削除の部分）
* ・Bootstrapによるレスポンシブ対応
* ・Rubocopを使用したコード規約に沿った開発

# アプリケーションの機能
* ・洋服のレビュー投稿
* ・画像投稿機能(carrierwave)
* ・コメント機能
* ・通知機能
* ・検索機能(Ransack)
* ・ログインログアウト機能(devise)
* ・ログイン状態の保持(devise)
* ・モデルに対するバリデーション
  
# 環境
* ・フレームワーク
* Ruby on Rails
* ・開発環境
* cloud9, sqlite3
* ・本番環境
*  heroku, postgreSQL, S3