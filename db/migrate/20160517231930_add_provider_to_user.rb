class AddProviderToUser < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string, null: false
  end
end