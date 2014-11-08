class AddItemTokenToDraft < ActiveRecord::Migration
  def change
    add_column :drafts, :item_token, :string
  end
end
