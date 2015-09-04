class TestRequestersController < ApplicationController
  before_action :init_wechat_client
  def index
    @requesters = TestRequester.all
    Rails.logger.info $test_wechat_client
    render json: @reqeusters
  end

  def show
    @requester = TestRequester.find_by_id params[:id]
    @responders = @requester.test_responder
    Rails.logger.info $test_wechat_client

    #@nresponder = TestResponder.new
    #@nresponder.test_requester = @requester
    #render :show
    #render json: @requester
  end

  def create
    @requester = TestRequester.new
    @requester.name = params[:name]
    @requester.save
    render json: @requester
  end

  def vote
    @requester = TestRequester.find_by_id params[:id]
    @responder = TestResponder.new
    @responder.name = params[:name]
    @responder.test_requester = @requester
    @responder.save
    redirect_to test_requester_path(@requester)
    #render json: @responder
    #@num = @responder.test_requester.test_responder.count
    #render json: {"num": @num}
  end
  private
  def init_wechat_client
    $test_wechat_client ||= WeixinAuthorize::Client.new(Rails.application.config.wechat_test['appid'], Rails.application.config.wechat_test['secret'])
  end
end
