class Article < ActiveRecord::Base
  before_validation :set_item_token

  acts_as_taggable

  has_many :comments

  extend FriendlyId
  friendly_id :item_token,
              use: [:slugged, :scoped],
              scope: :type

  validates :title, presence: true
  validates :user, presence: true

  belongs_to :user

  private
  def set_item_token
    self.item_token ||= SecureRandom.hex(10)
  end
end
