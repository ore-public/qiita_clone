class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i(create destroy)

  def create
    @user.followers.create(follower_id: current_user.id)
  end

  def destroy
    @user.followers.find_by(follower_id: current_user.id).destroy
    render :create
  end
end