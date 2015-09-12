class AddForbiddenForFirstPriceJoiner < ActiveRecord::Migration
  def change
    add_column :first_price_joiners, :forbidden, :bool
  end
end
