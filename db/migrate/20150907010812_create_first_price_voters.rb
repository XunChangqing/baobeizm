class CreateFirstPriceVoters < ActiveRecord::Migration
  def change
    create_table :first_price_voters do |t|
      t.string :nickname
      t.string :heading_url
      t.string :openid
      t.references :first_price_joiner, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
