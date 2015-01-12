class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: %i(create destroy edit update)
  before_action :set_comment, only: %i(destroy edit update)

  def index
  end

  def new
  end

  def create
    @comment = @item.comments.build(comment_params)
    @comment.user = current_user
    @comment.save!
  end

  def edit
  end

  def update
    @comment.update(comment_params)
  end

  def destroy
    @comment.destroy
  end

  private
  def set_item
    @item = Item.friendly.find(params[:item_id])
  end

  def set_comment
    @comment = @item.comments.where(user: current_user).find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:raw_body)
  end
end