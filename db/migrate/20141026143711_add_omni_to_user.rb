class AddOmniToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :uid, :string
  end
end
