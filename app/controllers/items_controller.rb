class ItemsController < ApplicationController
  before_action :set_item, only: [:show]

  def show
  end

  private
  def set_item
    @item = Item.friendly.find(params[:id])
  end

end
