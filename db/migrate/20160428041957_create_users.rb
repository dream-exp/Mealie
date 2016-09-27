class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :student_number
      t.integer :not_pay
      t.integer :use_count
      t.boolean :not_pay_confirm, default: false

      t.timestamps null: false
    end
  end
end
