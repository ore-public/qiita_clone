class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :article, index: true
      t.text :raw_body

      t.timestamps
    end
  end
end
