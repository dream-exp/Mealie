class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :student_number
      t.string :card_id
      t.integer :not_pay
      t.integer :use_count

      t.timestamps null: false
    end
  end
end
