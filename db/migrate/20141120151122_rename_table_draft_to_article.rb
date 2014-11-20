class RenameTableDraftToArticle < ActiveRecord::Migration
  def change
    rename_table :drafts, :articles
  end
end
