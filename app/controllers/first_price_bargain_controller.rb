class FirstPriceBargainController < ApplicationController
  before_action :auth_wechat, except: :entrance
  layout 'first_price_bargain'

  def show
    #Rails.logger.info sns_info.result['openid']
    #Rails.logger.info sns_info.result['access_token']
    #user_info = $first_wechat_client.get_oauth_userinfo(sns_info.result['openid'], sns_info.result['access_token'])
    #Rails.logger.info user_info.inspect
    @current_user = current_user
  end

  def create
  end

  private
  def current_user
    session[:user_info]
  end

  def auth_wechat
    Rails.logger.info session[:user_info].inspect
    if(session[:user_info] == nil)
      if(params[:code] == nil)
        Rails.logger.info 'redirect to' + wechat_client.authorize_url(request.url, 'snsapi_userinfo')
        redirect_to wechat_client.authorize_url(request.url, 'snsapi_userinfo')
      else
        sns_info = wechat_client.get_oauth_access_token(params[:code])
        user_info = wechat_client.get_oauth_userinfo(sns_info.result['openid'], sns_info.result['access_token'])
        session[:user_info] = user_info.result
      end
    end
  end
  def wechat_client
    $first_wechat_client ||= WeixinAuthorize::Client.new(Rails.application.config.wechat['first_appid'], Rails.application.config.wechat['first_secret'])
    $first_wechat_client.is_valid?
    $first_wechat_client
  end
end
