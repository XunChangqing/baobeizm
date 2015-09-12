class AddForbiddenIndexForFirstPriceJoiner < ActiveRecord::Migration
  def change
    add_index :first_price_joiners, :forbidden
  end
end
