class CreateParisPriceBargainVoters < ActiveRecord::Migration
  def change
    create_table :paris_price_bargain_voters do |t|
      t.string :name
      t.string :phone

      t.timestamps null: false
    end
    add_index :paris_price_bargain_voters, :phone, unique: true
  end
end
