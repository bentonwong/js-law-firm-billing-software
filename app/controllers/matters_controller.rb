class MattersController < ApplicationController
  before_action :set_matter, only: [:show, :edit, :update, :new_expense]
  before_action :authorized?

  def index
    @matters = Matter.all
  end

  def new
    @matter = Matter.new
  end

  def create
    @matter = Matter.new(matter_params)
    if @matter.save
      redirect_to @matter
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @matter.update(matter_params)
      redirect_to @matter
    else
      redirect_to edit_matter_path(@matter)
    end
  end

  def show
  end

  def destroy
  end

  private

    def set_matter
      @matter = Matter.find_by(id: params[:id])
    end

    def matter_params
      params.require(:matter).permit(:name, :lawyer_id, :client_id, :tag_ids => [], tags_attributes: [:name], notes_attributes: [:date, :content])
    end
end
