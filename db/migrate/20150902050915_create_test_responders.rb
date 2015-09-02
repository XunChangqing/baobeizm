class CreateTestResponders < ActiveRecord::Migration
  def change
    create_table :test_responders do |t|
      t.string :name
      t.references :test_requester, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
