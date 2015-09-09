class CreateFirstPriceJoiners < ActiveRecord::Migration
  def change
    create_table :first_price_joiners do |t|
      t.string :phone_number
      t.string :nickname
      t.string :heading_url
      t.string :openid
      t.integer :point

      t.timestamps null: false
    end
    add_index :first_price_joiners, :point
  end
end
