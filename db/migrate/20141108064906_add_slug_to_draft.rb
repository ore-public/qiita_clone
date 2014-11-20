class AddSlugToDraft < ActiveRecord::Migration
  def change
    add_column :drafts, :slug, :string
    add_index :drafts, :slug
  end
end
