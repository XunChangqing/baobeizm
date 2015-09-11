class ParisPriceBargainController < ApplicationController
  layout 'paris_price_bargain'
  def show
  end

  def vote
    unless params[:update] == 1
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
