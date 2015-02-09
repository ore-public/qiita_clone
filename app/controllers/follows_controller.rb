class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i(create destroy)

  def create
    follow = @user.followers.build(follower_id: current_user.id)
    follow.save!
  end

  def destroy
    follow = @user.followers.find_by(follower_id: current_user.id)
    follow.destroy
    render :create
  end
end