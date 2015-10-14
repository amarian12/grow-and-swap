class AddGardenReferenceToProduceItems < ActiveRecord::Migration
  def change
    add_reference :produce_items, :garden, index: true
    add_foreign_key :produce_items, :gardens
  end
end
