class DraftsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_draft, only: [:show, :edit, :update]
  respond_to :html

  def new
    @draft = current_user.drafts.build
  end

  def create
    @draft = current_user.drafts.build(draft_params)
    @draft.save

    if params[:public_create]
      @item = current_user.items.build(@draft.get_contents)
      @item.save
      redirect_to @item
    else
      respond_with(@draft)
    end
  end

  def show
  end

  def edit
  end

  def update
    @draft.update(draft_params)
    respond_with(@draft)
  end

  private
  def set_draft
    @draft = current_user.drafts.friendly.find(params[:id])
  end

  def draft_params
    params.require(:draft).permit(:title, :raw_body)
  end

end
