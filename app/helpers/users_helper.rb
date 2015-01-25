module UsersHelper
  def user_icon_small(user)
    user_icon(user, '20px')
  end

  def user_icon_normal(user)
    user_icon(user, '40px')
  end

  def user_icon_large(user)
    user_icon(user, '80px')
  end

  def user_icon(user, height = '20px')
    link_to (image_tag user.image_url, height: height, alt: user.nickname), user
  end
end
