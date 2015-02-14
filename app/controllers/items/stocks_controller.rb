class Items::StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: %i(create destroy)

  def create
    @item.stocks.create(stock_user: current_user)
  end

  def destroy
    @item.stocks.find_by(stock_user: current_user).destroy
     render :create
  end
end
