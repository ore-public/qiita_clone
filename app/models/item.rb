class Item < Article
  has_one :draft,
          :foreign_key => :slug,
          :primary_key => :slug

  has_many :stocks
  has_many :stock_users, through: :stocks, class_name: 'User'

  def stocked?(user)
    self.stock_users.include?(user)
  end

  def self.feeds(user)
    #follow_items = Item.where(user: user.follows)
    follow_tag_items = Item.tagged_with(user.tags, any: true)
    #sql = follow_items.union(follow_tag_items).to_sql
    #Item.from(#{sql} articles)

    #TODO: 本当はフォローしているユーザーの記事も一緒に返したいが unionがうまくいっていないので調べる
  end
end