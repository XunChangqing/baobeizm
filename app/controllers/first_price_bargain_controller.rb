class FirstPriceBargainController < ApplicationController
  include SimpleCaptcha::ControllerHelpers
  USERS = { "soufang" => "masa-masa" }
  before_action :authenticate, only: [:index_joiners, :index_voters]
  before_action :auth_wechat, except: [:index_joiners, :index_voters]
  layout 'first_price_bargain', except: [:index_joiners, :index_voters]
  layout 'first_price_bargain_internal', only: [:index_joiners, :index_voters]
  

  def show
    begin
      Rails.logger.info "Wechat access token: "+$first_wechat_client.access_token
    rescue
      Rails.logger.info "Wechat access token: first_wechat_client cannot init"
    end

    @current_openid = params[:openid]
    @current_user = current_user
    @joiners = FirstPriceJoiner.where(forbidden: [false, nil]).order(point: :desc, updated_at: :asc).page
    #@joiners = FirstPriceJoiner.order(point: :desc, updated_at: :asc).page
    @myjoiner = FirstPriceJoiner.find_by_openid(current_user['openid'])
    #params[:openid]
    if(params[:openid])
      @current_joiner = FirstPriceJoiner.find_by_openid params[:openid]
      if @current_joiner
        @nvoter = FirstPriceVoter.new
        @nvoter.first_price_joiner = @current_joiner
        @voters = @current_joiner.first_price_voter.order(:created_at).page if @current_joiner
        @has_vote = @current_joiner.first_price_voter.any?{ |voter| voter.openid == current_user['openid'] }
      end
    end
    #to get right share url
    #if @current_joiner == nil and @myjoiner != nil
      #redirect_to action: 'show', openid: @myjoiner.openid
    #else if @current_joiner ==nil and @myjoiner == nil
      #redirect_to action: 'show'
    #end

  end

  def join
    @joiner = FirstPriceJoiner.find_by_openid current_user['openid']
    if(! @joiner)
      @joiner = FirstPriceJoiner.new
      @joiner.openid = current_user['openid']
      @joiner.heading_url = current_user['headimgurl']
      @joiner.phone_number = params[:user][:phone]
      @joiner.name = params[:user][:name]
      @joiner.point = 0
      @joiner.nickname = current_user['nickname']
      @joiner.save
    end
    redirect_to action: 'show', openid: current_user['openid']
  end

  def vote
    np = params.require(:first_price_voter).permit(:captcha, :captcha_key, :first_price_joiner_id, :humanizer_answer, :humanizer_question_id)
    @voter = FirstPriceVoter.new(np)
    #byebug
    point_per = 5
    @voter.openid = current_user['openid']
    @voter.nickname = current_user['nickname']
    @voter.heading_url = current_user['headimgurl']
    #@voter.first_price_joiner = FirstPriceJoiner.find_by_id np['first_price_joiner_id']
    #j = @voter.first_price_joiner
    #j.with_lock do
    #j.point += point_per
    #j.save!
    #end
    #if @voter.first_price_joiner.forbidden
      #render json: {error: 1}
    #if @voter.save_with_captcha
    if not simple_captcha_valid? 
      render json: {error: 2}
    elsif @voter.save
      @voter.first_price_joiner.point = @voter.first_price_joiner.first_price_voter.count * point_per
      @voter.first_price_joiner.save
      render json: {point: @voter.first_price_joiner.point, rank: @voter.first_price_joiner.rank}
    else
      render json: {error: 1}
    end
  end

  def show_joiners
    @joiners = FirstPriceJoiner.where(forbidden: [false, nil]).order(point: :desc, updated_at: :asc).page(params[:page])
    #@joiners = FirstPriceJoiner.order(point: :desc, updated_at: :asc).page(params[:page])
    #@joiners = FirstPriceJoiner.page(params[:page])
    if @joiners
      @page_offset = (@joiners.current_page-1)*25+1
    end
  end

  def show_voters
    @current_joiner = FirstPriceJoiner.find_by_openid(params[:openid])
    #byebug
    if @current_joiner
      @voters = @current_joiner.first_price_voter.order(created_at: :desc).page(params[:page])
    end
  end

  def index_joiners
    @joiners = FirstPriceJoiner.all.order(point: :desc)
  end

  def index_voters
    @voters = FirstPriceJoiner.find_by_openid(params[:openid]).first_price_voter.order(created_at: :desc)
  end

  public
  def current_user
    if Rails.env == "development"
      user = {}
      user['nickname'] = '14t'
      user['openid'] = 'xvsdf065ys980880'
      user['headimgurl'] = 'http://wx.qlogo.cn/mmopen/uTUcW8j8NyRkGQjsrhgYatgtxp0pgcPve6VqEtnwe02WHuuzTkEjS51kOb0jyArNrpgUOmKLYR7NnVY5SWg5CVISicm1ic4IWic/0'
      user
    else
      session[:user_info]
    end
  end

  private
  def auth_wechat
    Rails.logger.info "auth_wechat: "+current_user.inspect
    if(current_user == nil or current_user['openid']==nil)
      if(params[:code] == nil)
        #Rails.logger.info 'redirect to' + $first_wechat_client.authorize_url(request.url, 'snsapi_userinfo')
        redirect_to $first_wechat_client.authorize_url(request.url, 'snsapi_userinfo')
      else
        sns_info = $first_wechat_client.get_oauth_access_token(params[:code])
        #if sns_info.result['access_token'] == nil
        #redirect_to action: 'show', openid: params[:openid]
        #end
        user_info = $first_wechat_client.get_oauth_userinfo(sns_info.result['openid'], sns_info.result['access_token'])
        if user_info.result['openid'] == nil
          redirect_to action: 'show', openid: params[:openid]
        end
        session[:user_info] = user_info.result
      end
    end
  end

  def authenticate
    authenticate_or_request_with_http_digest do |username|
      USERS[username]
    end
  end
end
