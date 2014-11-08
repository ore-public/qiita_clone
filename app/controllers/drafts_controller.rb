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
    respond_with(@draft)
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
    @draft = current_user.drafts.find(params[:id])
  end

  def draft_params
    params.require(:draft).permit(:title, :raw_body)
  end

end
