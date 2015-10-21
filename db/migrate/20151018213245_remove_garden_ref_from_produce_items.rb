class RemoveGardenRefFromProduceItems < ActiveRecord::Migration
  def change
    remove_reference :produce_items, :garden, index: true
  end
end
