class AddPhotoToProduceItem < ActiveRecord::Migration
  def change
    add_column :produce_items, :photo, :string, default: "", null: false
  end
end
