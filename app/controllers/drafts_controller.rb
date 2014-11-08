class DraftsController < ApplicationController
  before_action :set_draft, only: [:show, :edit, :update]
  respond_to :html

  def new
    @draft = Draft.new
  end

  def create
    @draft = Draft.new(draft_params)
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
    @draft = Draft.find(params[:id])
  end

  def draft_params
    params.require(:draft).permit(:title, :raw_body)
  end

end
