class MattersController < ApplicationController
  before_action :set_matter, only: [:show, :edit, :update, :new_expense]

  def index
    @matters = Matter.all
  end

  def new
    @matter = Matter.new
  end

  def create
    matter = Matter.new(matter_params)
    if matter.save
      redirect_to matter_path(matter)
    else
      redirect_to new_matter_path
    end
  end

  def edit
  end

  def update
    @matter.update(matter_params)
    redirect_to @matter
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
      params.require(:matter).permit(:name, :lawyer_id, :client_id)
    end
end
