class MattersController < ApplicationController
  before_action :set_matter, only: [:show, :edit, :update, :time_entries]
  before_action :authorized?

  def index
    @matters = Matter.all
  end

  def new
    @matter = Matter.new
  end

  def create
    @matter = Matter.new(matter_params)
    save_matter
  end

  def edit
  end

  def update
    update_matter
  end

  def show
  end

  def time_entries
    render :time_entries
  end

  private

    def set_matter
      @matter = Matter.find_by(id: params[:id])
    end

    def matter_params
      params.require(:matter).permit(:name, :lawyer_id, :client_id, :tag_ids => [], tags_attributes: [:name], notes_attributes: [:date, :content])
    end
end
