class Follow < ActiveRecord::Base
  belongs_to :follower_user, class_name: 'User', foreign_key: :follower_id
  belongs_to :follow_user, class_name: 'User', foreign_key: :user_id
end
