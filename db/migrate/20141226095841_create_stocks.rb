class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.references :user, index: true
      t.references :item, index: true

      t.timestamps
    end
  end
end
