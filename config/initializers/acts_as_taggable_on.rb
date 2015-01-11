ActsAsTaggableOn::Tag.class_eval do
  extend FriendlyId

  friendly_id :name, use: :slugged
  validates :slug, uniqueness: true

  has_many :tag_follows
  has_many :users, through: :tag_follows

  def followed?(user)
    self.users.include?(user)
  end
end