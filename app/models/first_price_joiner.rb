class FirstPriceJoiner < ActiveRecord::Base
  has_many :first_price_voter
  validates :openid, presence: true
  validates :phone_number, presence: true
  #validates :nickname, presence: true
  #validates :heading_url, presence: true
  validates :point, presence: true
  def rank
    FirstPriceJoiner.where("point > ?", point).count + 1
  end
end
