class AddNameToFirstPriceJoiner < ActiveRecord::Migration
  def change
    add_column :first_price_joiners, :name, :string
  end
end
