class Article < ActiveRecord::Base
  default_value_for :item_token, SecureRandom.hex(10)

  extend FriendlyId
  friendly_id :item_token,
              use: [:slugged, :scoped],
              scope: :type

  validates :title, presence: true
  validates :item_token, presence: true,
            uniqueness: {scope: [:type]}

  belongs_to :user

end
