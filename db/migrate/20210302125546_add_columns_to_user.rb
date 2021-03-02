class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :lasttime, :string,default: ""
    add_column :users, :is_work, :boolean,null: false,default: true
  end
end
