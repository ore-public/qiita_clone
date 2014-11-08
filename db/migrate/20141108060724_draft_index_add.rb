class DraftIndexAdd < ActiveRecord::Migration
  def change
    add_index :drafts, :title
  end
end
