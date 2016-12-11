class AddAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :street, :string, default: "", null: false
    add_column :users, :city, :string, default: "", null: false
    add_column :users, :state, :string, default: "", null: false
    add_column :users, :zip_code, :string, default: "", null: false
    add_column :users, :latitude, :float, default: 0.0, null: false
    add_column :users, :longitude, :float, default: 0.0, null: false
  end
end
