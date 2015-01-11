class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :omniauthable, :omniauth_providers => [:github]

  acts_as_tagger
  has_many :drafts
  has_many :items
  has_many :stocks
  has_many :stock_items, through: :stocks, class_name: 'Item'
  has_many :follows
  has_many :follower_users, through: :follows, source: :follower_user
  has_many :follow_users, through: :follows, source: :follow_user
  has_many :tag_follows
  has_many :tags, through: :tag_follows, class_name: 'ActsAsTaggableOn::Tag'

  extend FriendlyId
  friendly_id :nickname, use: :slugged

  validates :email, uniqueness: true, presence: true
  validates :nickname, presence: true
  validates :slug, uniqueness: true, presence: true

  def self.find_for_oauth(auth)
    u = User.where(:provider => auth["provider"], :uid => auth.uid)
    case auth["provider"].to_sym
      when :github
        u.first_or_create(name: auth.extra.raw_info.name, email: auth.info.email, nickname: auth.info.nickname)
    end
  end

  def followed?(user)
    self.follower_users.include?(user)
  end
end
