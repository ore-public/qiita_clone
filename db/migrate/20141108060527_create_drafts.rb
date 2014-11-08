class CreateDrafts < ActiveRecord::Migration
  def change
    create_table :drafts do |t|
      t.string :title
      t.text :raw_body

      t.timestamps
    end
  end
end
