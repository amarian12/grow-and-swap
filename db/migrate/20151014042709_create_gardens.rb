class CreateGardens < ActiveRecord::Migration
  def change
    create_table :gardens do |t|
      t.integer :quantity, default: 0, null: false
      t.references :user, index: true

      t.timestamps null: false
    end

    add_foreign_key :gardens, :users
  end
end
