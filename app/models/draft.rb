class Draft < Article
  has_one :item,
          :foreign_key => :slug,
          :primary_key => :slug

  def get_contents
    {
      title: self.title,
      raw_body: self.raw_body,
      item_token: self.item_token
    }
  end
end
