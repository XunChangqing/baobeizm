require 'yaml'
Rails.application.config.wechat_test = YAML.load_file(Rails.root.join('config', 'wechat_test.yml'))[Rails.env]
#$wechat_client ||= WeixinAuthorize::Client.new("wx47036a3c431b59a9", "c238bd1564de71932f1e528fb477d044")
$test_wechat_client ||= WeixinAuthorize::Client.new(Rails.application.config.wechat_test['appid'], Rails.application.config.wechat_test['secret'])
