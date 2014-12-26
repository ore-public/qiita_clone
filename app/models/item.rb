class Item < Article
  has_one :draft,
          :foreign_key => :slug,
          :primary_key => :slug

  has_many :stocks
  has_many :stock_users, through: :stocks, class_name: 'User'

  def stocked?(user)
    self.stock_users.include?(user)
  end
end