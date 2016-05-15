class CreatePaymentsUsers < ActiveRecord::Migration
  def change
    create_table :payments_users do |t|

    	t.integer :student_number

      t.timestamps null: false
    end
  end
end
