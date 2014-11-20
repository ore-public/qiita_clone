class AddTypeToDraft < ActiveRecord::Migration
  def change
    add_column :drafts, :type, :string
    add_index :drafts, [:slug, :type], unique: true
  end
end
