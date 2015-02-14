class TagFollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tag, only: %i(create destroy)

  def create
    current_user.tag_follows.create(tag: @tag)
  end

  def destroy
    current_user.tag_follows.find_by(tag: @tag).destroy
    render :create
  end

  private
  def set_tag
    @tag = ActsAsTaggableOn::Tag.friendly.find(params[:tag_id])
  end
end
