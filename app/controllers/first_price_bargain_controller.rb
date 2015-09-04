class FirstPriceBargainController < ApplicationController
  before_action :init_wechat_client
  layout 'first_price_bargain'

  def entrance
    Rails.logger.info first_price_bargain_show_url
    redirect_to $first_wechat_client.authorize_url(first_price_bargain_show_url)
  end

  def show
    sns_info = $first_wechat_client.get_oauth_access_token(params[:code])
    Rails.logger.info params[:code]
    #@user_info = $first_wechat_client.get_oauth_userinfo(openid, oauth_token)
    Rails.logger.info sns_info
  end
  def create
  end

  private
  def init_wechat_client
    $first_wechat_client ||= WeixinAuthorize::Client.new(Rails.application.config.wechat['first_appid'], Rails.application.config.wechat['first_secret'])
    $first_wechat_client.is_valid?
  end
end
