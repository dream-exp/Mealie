class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :name
      t.integer :price
      t.string :category
      t.string :imageurl
      t.integer :cal
      t.string :allergy
      t.integer :quantity
      t.string :day
      t.integer :page_view
      t.integer :purchase_count

      t.timestamps null: false
    end
  end
end
