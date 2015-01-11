class TagFollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tag, only: %i(create destroy)

  def create
    tag_follow = current_user.tag_follows.build(tag: @tag)
    tag_follow.save!
  end

  def destroy
    tag_follow = current_user.tag_follows.find_by(tag: @tag)
    tag_follow.destroy
  end

  private
  def set_tag
    @tag = ActsAsTaggableOn::Tag.friendly.find(params[:tag_id])
  end
end
