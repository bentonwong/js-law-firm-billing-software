class TagsController < ApplicationController
  before_action :authorized?, except: [:new, :home]

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find_by(id: params[:id])
  end

  def destroy
  end
end
