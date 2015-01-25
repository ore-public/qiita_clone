class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :omniauthable, :omniauth_providers => [:github]

  acts_as_tagger
  has_many :drafts
  has_many :items
  has_many :stocks
  has_many :stock_items, through: :stocks, class_name: 'Item'
  has_many :followers, class_name: 'Follow'
  has_many :follower_users, through: :followers, source: :follower_user
  has_many :follows, foreign_key: :follower_id
  has_many :follow_users, through: :follows, source: :follow_user
  has_many :tag_follows
  has_many :tags, through: :tag_follows, class_name: 'ActsAsTaggableOn::Tag'

  extend FriendlyId
  friendly_id :nickname, use: :slugged

  validates :email, uniqueness: true, presence: true
  validates :nickname, presence: true
  validates :slug, uniqueness: true, presence: true

  def self.find_for_oauth(auth)
    u = User.find_or_create_by(:provider => auth["provider"], :uid => auth.uid)
    case auth["provider"].to_sym
      when :github
          u.name = auth.extra.raw_info.name
          u.email = auth.info.email
          u.nickname = auth.info.nickname
          u.image_url = auth.info.image
    end
    u.save!
    u
  end

  def followed?(user)
    self.follower_users.include?(user)
  end
end
