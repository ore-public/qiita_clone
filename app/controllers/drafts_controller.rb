class DraftsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_draft, only: [:show, :edit, :update]
  respond_to :html

  def index
    @drafts = current_user.drafts.page(params[:page])
  end

  def show
  end

  def new
    @draft = current_user.drafts.build
  end

  def edit
  end

  def create
    @draft = current_user.drafts.build(draft_params)
    save_draft_and_item('new')
  end

  def update
    @draft.update(draft_params)
    save_draft_and_item('edit')
  end

  private
  def set_draft
    @draft = current_user.drafts.friendly.find(params[:id])
  end

  def draft_params
    params.require(:draft).permit(:title, :raw_body, :tag_list)
  end

  def save_draft_and_item(action)
    if @draft.save
      if params[:public]
        @item = @draft.public_item!
        save_item(action)
      else
        redirect_to @draft
      end
    else
      render action
    end
  end

  def save_item(action)
    if @item.save
      redirect_to @item
    else
      render action
    end
  end
end
