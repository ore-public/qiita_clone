class Draft < ActiveRecord::Base
  before_validation :set_item_token
  extend FriendlyId
  friendly_id :item_token, use: [:slugged, :finders]

  validates :title, presence: true
  validates :item_token, presence: true, uniqueness: true

  belongs_to :user

  private
  def set_item_token
    self.item_token ||= SecureRandom.hex(10)
  end
end
