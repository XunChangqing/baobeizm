class FirstPriceVoter < ActiveRecord::Base
  apply_simple_captcha
  belongs_to :first_price_joiner
  #validates :nickname, presence: true
  validates :openid, presence: true
  #validates :heading_url, presence: true
  validates :first_price_joiner, presence: true
end
