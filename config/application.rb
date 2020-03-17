require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ClothesApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.i18n.default_locale = :ja
    config.web_console.whitelisted_ips = '139.101.24.9'
 

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.generators do |g|
      g.assets false             # CSS/JSファイル生成せず
      g.skip_routes false        # trueなら routes.rb変更せず
      g.helper false             # ヘルパー生成せず
      g.test_framework :rspec,   # テストフレームワークはrspecを使用の場合
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       controller_specs: true,
                       request_specs: false,
                       fixtures: true
	   g.fixture_replacement :factory_bot, dir: "spec/factories"  # fixtureはfactory_botでディレクトリを変更
    end
  end
end
