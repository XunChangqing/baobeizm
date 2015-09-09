class AddIndexToJoiner < ActiveRecord::Migration
  def change
    add_index :first_price_joiners, :openid, :unique => true
  end
end
