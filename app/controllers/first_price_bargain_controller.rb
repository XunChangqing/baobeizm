class FirstPriceBargainController < ApplicationController
  before_action :init_wechat_client
  layout 'first_price_bargain'

  def show
  end

  private
  def init_wechat_client
    $first_wechat_client ||= WeixinAuthorize::Client.new(Rails.application.config.wechat['first_appid'], Rails.application.config.wechat['first_secret'])
    $first_wechat_client.is_valid?
  end
end
