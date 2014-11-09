class Draft < ActiveRecord::Base
  default_value_for :item_token, SecureRandom.hex(10)
  extend FriendlyId
  friendly_id :item_token, use: [:slugged, :finders]

  validates :title, presence: true
  validates :item_token, presence: true, uniqueness: true

  belongs_to :user

end
