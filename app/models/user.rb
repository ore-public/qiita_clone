class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :omniauthable, :omniauth_providers => [:github]

  has_many :drafts
  has_many :items
  has_many :stocks
  has_many :stock_items, through: :stocks, class_name: 'Item'

  acts_as_tagger

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
end
