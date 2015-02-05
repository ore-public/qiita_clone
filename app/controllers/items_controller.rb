class ItemsController < ApplicationController
  before_action :set_item, only: [:show]

  def index
    @items = @search.result.page(params[:page])
  end

  def show
    @comment = Comment.new
  end

  private
  def set_item
    @item = Item.friendly.find(params[:id])
  end

end
