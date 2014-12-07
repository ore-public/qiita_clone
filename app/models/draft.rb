class Draft < Article
  has_one :item,
          :foreign_key => :slug,
          :primary_key => :slug

  def get_contents
    {
      title: self.title,
      raw_body: self.raw_body,
      item_token: self.item_token,
      slug: self.slug
    }
  end

  def new_public_item
    unless self.item
      self.create_item!(self.get_contents)
    else
      raise 'Already created public item.'
    end
  end

  def update_public_item
    if self.item
      self.item.update_attributes(self.get_contents)
    else
      raise 'Public item not created.'
    end
  end
end
