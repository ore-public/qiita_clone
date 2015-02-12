class Draft < Article
  has_one :item,
          :foreign_key => :slug,
          :primary_key => :slug

  def public_item!
    if self.item
      update_public_item
    else
      new_public_item
    end
  end

  private
  def get_contents
    {
        title: self.title,
        raw_body: self.raw_body,
        item_token: self.item_token,
        slug: self.slug,
        user: self.user,
        tag_list: self.tag_list
    }
  end

  def new_public_item
    unless self.item
      self.create_item!(get_contents)
    else
      raise 'Already created public item.'
    end
  end

  def update_public_item
    if self.item
      self.item.update_attributes!(get_contents)
      self.item
    else
      raise 'Public item not created.'
    end
  end

end
