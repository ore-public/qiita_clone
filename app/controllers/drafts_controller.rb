class DraftsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_draft, only: [:show, :edit, :update]
  respond_to :html

  def new
    @draft = current_user.drafts.build
  end

  def create
    @draft = current_user.drafts.build(draft_params)
    if @draft.save
      if params[:public_create]
        @item = current_user.items.build(@draft.get_contents)
        if @item.save
          redirect_to @item
        else
          render 'new'
        end
      else
        redirect_to @draft
      end
    else
      render 'new'
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
