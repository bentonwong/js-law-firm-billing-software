class CasesController < ApplicationController
  before_action :set_case, only: [:show, :edit]

  def index
    @cases = Case.all
  end

  def new
    @case = Case.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end

  private

    def set_case
      @case = Case.find_by(id: params[:id])
    end

end
