class TagsController < ApplicationController
  def show
    @tag = ActsAsTaggableOn::Tag.friendly.find(params[:id])
  end
end