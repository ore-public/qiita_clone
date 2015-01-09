class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.references :user, index: true
      t.integer :follower_id

      t.timestamps
    end

    add_index :follows, :follower_id
  end
end
