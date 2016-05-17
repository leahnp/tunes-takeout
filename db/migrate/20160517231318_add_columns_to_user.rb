class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string, null: false
    add_column :users, :name, :string, null: false
    add_column :users, :photo, :string
  end
end
