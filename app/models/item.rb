class Item < Article
  has_one :draft,
          :foreign_key => :slug,
          :primary_key => :slug

  has_many :stocks
  has_many :stock_users, through: :stocks, class_name: 'User'

  # feed取得で OR 条件構築のため tagged_with 使わずにタグの記事を検索するscopeを作成している
  # tagged_withで生成されるSQLのEXSISTの部分と、STIのための TYPE IN ('ITEM') 部分が
  # OR条件構築の時に文法エラーになってうまくいかないため。
  scope :follow_tagged_items, ->(tags) {
    where(id: ActsAsTaggableOn::Tagging.where{ tag_id.in(tags)}.pluck(:taggable_id))
  }

  scope :follow_user_items, ->(users) { where(user: users)}

  def stocked?(user)
    self.stock_users.include?(user)
  end

  def self.feeds(user)
    # where_valuesの時に user.follow_usersへの bind parametersが消えて後の or でうまくいかないので
    # 仕方なくpluckでfollow_usersのidのArrayを渡すようにした
    # もう少し綺麗に書けないか調べる
    follow_user_items_cond = Item.follow_user_items(user.follow_users.pluck(:id)).where_values.reduce(:and)
    follow_tagged_items_cond = Item.follow_tagged_items(user.tags).where_values.reduce(:and)

    Item.where(follow_user_items_cond.or(follow_tagged_items_cond))
  end
end