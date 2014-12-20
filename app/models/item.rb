class Item < Article
  has_one :draft,
          :foreign_key => :slug,
          :primary_key => :slug

end