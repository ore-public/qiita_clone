class UsersController < ApplicationController
  def show
    @user = User.friendly.find(params[:id])
    @items = @user.items.page(params[:page])
  end
end
