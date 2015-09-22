class FirstPriceJoiner < ActiveRecord::Base
  has_many :first_price_voter
  validates :openid, presence: true
  validates :phone_number, presence: true
  #validates :nickname, presence: true
  #validates :heading_url, presence: true
  validates :point, presence: true
  validates :name, presence: true
  def rank
    bigcount = FirstPriceJoiner.where("point > ?", point).count
    equalcount = FirstPriceJoiner.where("point = ? AND updated_at < ?", point, updated_at).count
    #@joiners = FirstPriceJoiner.where(forbidden: [false, nil]).order(point: :desc, updated_at: :asc).page(params[:page])
    #bigcount+equalcount+1
    #临时处理由于封号导致个人排名和排名榜不一致的情况
    bigcount+equalcount
  end
end
