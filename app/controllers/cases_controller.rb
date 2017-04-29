class CasesController < ApplicationController
  before_action :set_case, only: [:show, :edit]

  def index
    @cases = Case.all
  end

  def new
    @case = Case.new
  end

  def create
    case = Case.new(params)
    if case.save
      redirect_to case_path(case)
    else
      redirect_to new_case_path
    end
  end

  def edit
  end

  def update
    @case.update(params)
    redirect_to @case
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
