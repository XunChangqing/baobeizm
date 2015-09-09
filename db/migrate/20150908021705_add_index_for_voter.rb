class AddIndexForVoter < ActiveRecord::Migration
  def change
    add_index :first_price_voters, [:first_price_joiner_id, :openid], :unique => true
  end
end
