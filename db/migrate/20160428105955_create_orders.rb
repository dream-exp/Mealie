class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :student_number
      t.integer :menu_id
      t.string :menu_name
      t.integer :price
      t.string :status

      t.timestamps null: false
    end
  end
end
