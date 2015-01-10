class StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: %i(create destroy)

  def create
    current_user.stock_items << @item
  end

  def destroy
    current_user.stocks.find_by_item_id!(@item).destroy
  end

  def index
    @stocks = User.friendly.find(params[:user_id]).stock_items.page(params[:page])
  end

  private
  def set_item
    @item = Item.friendly.find(params[:item_id])
  end
end
