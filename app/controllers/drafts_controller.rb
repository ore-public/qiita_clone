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
    @draft.public = params[:public].present?

    if @draft.save
      redirect_to @draft.save_item
    else
      render 'new'
    end
  end

  def update
    @draft.update(draft_params)
    @draft.public = params[:public].present?

    if @draft.save
      redirect_to @draft.save_item
    else
      render 'edit'
    end
  end

  private
  def set_draft
    @draft = current_user.drafts.friendly.find(params[:id])
  end

  def draft_params
    params.require(:draft).permit(:title, :raw_body, :tag_list)
  end
end
