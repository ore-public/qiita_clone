class ItemsController < ApplicationController
  before_action :set_item, only: [:show]

  def show
    @comment = Comment.new
  end

  def index
    @items = @search.result.page(params[:page])
  end

  private
  def set_item
    @item = Item.friendly.find(params[:id])
  end

end
