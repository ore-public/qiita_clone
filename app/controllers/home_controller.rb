class HomeController < ApplicationController
  def index
    @items = Item.all
  end

  def auth
  end
end
