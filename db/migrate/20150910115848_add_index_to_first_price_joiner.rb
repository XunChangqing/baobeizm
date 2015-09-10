class AddIndexToFirstPriceJoiner < ActiveRecord::Migration
  def change
    add_index :first_price_joiners, :updated_at
  end
end
