class Users::StocksController < ApplicationController
  before_action :authenticate_user!

  def index
    @stocks = User.friendly.find(params[:user_id]).stock_items.page(params[:page])
  end

end
