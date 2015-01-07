class Stock < ActiveRecord::Base
  belongs_to :stock_user, class_name: 'User', foreign_key: :user_id
  belongs_to :stock_item, class_name: 'Item', foreign_key: :item_id
end
