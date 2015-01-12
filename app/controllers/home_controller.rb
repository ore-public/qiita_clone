class HomeController < ApplicationController
  before_action :authenticate_user!, only: %i(index)

  def index
    @items = Item.feeds(current_user).page(params[:page])
  end

  def auth
  end
end
