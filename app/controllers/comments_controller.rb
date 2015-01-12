class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: %i(create destroy)

  def index

  end

  def new

  end

  def create
    @comment = @item.comments.build(comment_params)
    @comment.save!
  end

  def edit

  end

  def update

  end

  def destroy
    @item.comments.find(params[:id]).destroy
  end

  private
  def set_item
    @item = Item.friendly.find(params[:item_id])
  end

  def comment_params
    params.require(:comment).permit(:raw_body)
  end
end