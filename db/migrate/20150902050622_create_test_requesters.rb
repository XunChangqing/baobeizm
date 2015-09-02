class CreateTestRequesters < ActiveRecord::Migration
  def change
    create_table :test_requesters do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
