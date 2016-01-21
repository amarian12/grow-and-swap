class ChangeColumnNullGardenItems < ActiveRecord::Migration
  def change
    change_column_null :garden_items, :user_id, false
    change_column_null :garden_items, :produce_item_id, false
  end
end
