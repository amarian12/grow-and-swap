class AddProduceItemRefToGardens < ActiveRecord::Migration
  def change
    add_reference :gardens, :produce_item, index: true
    add_foreign_key :gardens, :produce_items
  end
end
