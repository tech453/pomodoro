class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :work,null: false,default: 25
      t.integer :short_break,null: false,default: 5
      t.integer :long_break,null: false,default: 15
      t.integer :today_work_count,null: false,default: 0

      t.timestamps
    end
  end
end
