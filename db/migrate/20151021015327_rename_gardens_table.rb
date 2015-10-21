class RenameGardensTable < ActiveRecord::Migration
  def change
    rename_table :gardens, :garden_items
  end
end