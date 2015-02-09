class Users::StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: :index

  def index
    @stocks = @user.stock_items.page(params[:page])
  end

end
