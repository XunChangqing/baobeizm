class ParisPriceBargainController < ApplicationController
  layout 'paris_price_bargain', except: :show_pc
  layout 'paris_price_bargain_pc', only: :show_pc
  def show_pc
    response.headers.delete "X-Frame-Options"
  end
  def show
    response.headers.delete "X-Frame-Options"
    #response.headers["X-FRAME-OPTIONS"] = "ALLOW-FROM http://some-origin.com"
  end

  def vote
    unless params[:update] == "1"
      @voter = ParisPriceBargainVoter.new
      @voter.name = params[:user][:name]
      @voter.phone = params[:user][:phone]
      @voter.save
    end
    render json: {count: ParisPriceBargainVoter.count}
  end

  def index
    @voters = ParisPriceBargainVoter.page params[:page]
  end
  def export
    @voters = ParisPriceBargainVoter.all
    render xlsx: 'export', :filename=>"报名名单"
  end
end
