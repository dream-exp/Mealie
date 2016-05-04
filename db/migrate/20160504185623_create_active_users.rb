class CreateActiveUsers < ActiveRecord::Migration
  def change
    create_table :active_users do |t|
      t.integer :student_number

      t.timestamps null: false
    end
  end
end
