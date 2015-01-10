class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    follow = @user.follows.build(follower_id: current_user.id)
    follow.save!
    render js: 'location.reload();'
  end

  def destroy
    follow = @user.follows.find_by(follower_id: current_user.id)
    follow.destroy
    render js: 'location.reload();'
  end

  private
  def set_user
    @user = User.friendly.find(params[:user_id])
  end
end