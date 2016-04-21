class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :food_name
      t.string :food_url
      t.string :image_url
      t.integer :food_price
      t.integer :calorie
      t.string :allergy
      t.integer :quantity
      t.string :days

      t.timestamps null: false
    end
  end
end
