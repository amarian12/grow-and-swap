class AddPhotoToGardenItem < ActiveRecord::Migration
  def change
    add_column :garden_items, :photo, :string, default: "", null: false
  end
end
