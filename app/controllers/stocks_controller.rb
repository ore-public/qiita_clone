class StocksController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.stock_items << Item.friendly.find(params[:item_id])
    render js: 'location.reload();'
  end

  def destroy
    current_user.stocks.find_by_item_id!(Item.friendly.find(params[:item_id])).destroy
    render js: 'location.reload();'
  end

  def index
    @stocks = User.friendly.find(params[:user_id]).stock_items
  end
end
