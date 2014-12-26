class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :omniauthable, :omniauth_providers => [:github]

  has_many :drafts
  has_many :items
  has_many :stocks
  has_many :stock_items, through: :stocks, class_name: 'Item'

  def self.find_for_oauth(auth)
    u = User.where(:provider => auth["provider"], :uid => auth.uid)
    case auth["provider"].to_sym
      when :github
        u.first_or_create(:name => auth.extra.raw_info.name, :email => auth.info.email)
    end
  end
end
