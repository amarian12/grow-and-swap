class CreateProduceItems < ActiveRecord::Migration
  def change
    create_table :produce_items do |t|
      t.string :name, default: "", null: false
      t.string :category, default: "", null: false

      t.timestamps null: false
    end
  end
end
