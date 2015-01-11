ActsAsTaggableOn::Tag.class_eval do
  extend FriendlyId

  friendly_id :name, use: :slugged
  validates :slug, uniqueness: true

end