class AddUserToDraft < ActiveRecord::Migration
  def change
    add_reference :drafts, :user, index: true
  end
end
