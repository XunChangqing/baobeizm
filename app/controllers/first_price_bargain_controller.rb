class FirstPriceBargainController < ApplicationController
  before_action :auth_wechat
  layout 'first_price_bargain'

  def show
    @joiners = FirstPriceJoiner.order(point: :desc, updated_at: :asc).page
    @myjoiner = FirstPriceJoiner.find_by_openid(current_user['openid'])
    #params[:openid]
    if(params[:openid])
      @current_joiner = FirstPriceJoiner.find_by_openid params[:openid]
      if @current_joiner
        @voters = @current_joiner.first_price_voter.order(:created_at).page if @current_joiner
        @has_vote = @current_joiner.first_price_voter.any?{ |voter| voter.openid == current_user['openid'] }
      end
    end
    #to get right share url
    if @current_joiner == nil and @myjoiner != nil
      redirect_to action: 'show', openid: current_user['openid']
    end
  end

  def join
    @joiner = FirstPriceJoiner.find_by_openid current_user['openid']
    if(! @joiner)
      @joiner = FirstPriceJoiner.new
      @joiner.openid = current_user['openid']
      @joiner.heading_url = current_user['headimgurl']
      @joiner.phone_number = params[:user][:phone]
      @joiner.point = 0
      @joiner.nickname = current_user['nickname']
      @joiner.save
    end
    redirect_to action: 'show', openid: current_user['openid']
  end

  def vote
    point_per = 5
    @voter = FirstPriceVoter.new
    @voter.openid = current_user['openid']
    @voter.nickname = current_user['nickname']
    @voter.heading_url = current_user['headimgurl']
    @voter.first_price_joiner = FirstPriceJoiner.find_by_openid params[:openid]
    @voter.first_price_joiner.with_lock do
      @voter.first_price_joiner.point += point_per
      @voter.first_price_joiner.save!
    end
    if @voter.save
      render json: {point: @voter.first_price_joiner.point, rank: @voter.first_price_joiner.rank}
    else
      render json: {error: 1}
    end
  end

  def show_joiners
    @joiners = FirstPriceJoiner.order(point: :desc, updated_at: :asc).page(params[:page])
    #@joiners = FirstPriceJoiner.page(params[:page])
    if @joiners
      @page_offset = (@joiners.current_page-1)*25+1
    end
  end

  def show_voters
    @current_joiner = FirstPriceJoiner.find_by_openid(params['openid'])
    #byebug
    if @current_joiner
      @voters = @current_joiner.first_price_voter.order(:created_at).page(params[:page])
    end
  end

  private
  def current_user
    #user = {}
    #user['nickname'] = 'other'
    #user['openid'] = 'xvsdf065ys980880'
    #user['headimgurl'] = 'http://www.ifeng.com/xyz.jpg'
    #user
    session[:user_info]
  end

  def auth_wechat
    #Rails.logger.info session[:user_info].inspect
    wechat_client()
    if(session[:user_info] == nil)
      if(params[:code] == nil)
        #Rails.logger.info 'redirect to' + wechat_client.authorize_url(request.url, 'snsapi_userinfo')
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
