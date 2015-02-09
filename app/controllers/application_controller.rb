class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_search

  private
  def set_search
    @search = Item.search(params[:q])
  end

  def set_item
    @item = Item.friendly.find(params[:item_id])
  end

  def set_user
    @user = User.friendly.find(params[:user_id])
  end
end
