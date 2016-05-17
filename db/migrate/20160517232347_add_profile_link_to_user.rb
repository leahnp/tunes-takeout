class AddProfileLinkToUser < ActiveRecord::Migration
  def change
    add_column :users, :profile_link, :string, null: false
  end
end
