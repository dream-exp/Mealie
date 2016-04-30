class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :student_number
      t.string :card_id
      t.text :orderarray
      t.integer :not_pay

      t.timestamps null: false
    end
  end
end
