class Items::StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: %i(create destroy)

  def create
    current_user.stock_items << @item
  end

  def destroy
    current_user.stocks.find_by_item_id!(@item).destroy
    render :create
  end
end
