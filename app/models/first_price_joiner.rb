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
    bigcount+equalcount+1
  end
end
