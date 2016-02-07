class CreateTradeOffers < ActiveRecord::Migration
  def change
    create_table :trade_offers do |t|
      t.integer :quantity, default: 1, null: false
      t.boolean :accepted, default: false, null: false
      t.integer :user_id, null: false
      t.integer :garden_item_id, null: false
      t.index :user_id
      t.index :garden_item_id

      t.timestamps null: false
    end

    add_foreign_key :trade_offers, :users
    add_foreign_key :trade_offers, :garden_items
  end
end
