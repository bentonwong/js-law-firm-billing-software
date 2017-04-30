class LawCasesController < ApplicationController
  before_action :set_case, only: [:show, :edit, :update]

  def index
    @cases = LawCases.all
  end

  def new
    @case = LawCase.new
  end

  def create

  end

  def edit
  end

  def update
    @case.update(case_params)
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

    def case_params
      params.require(:case).permit(:name, :lawyer, :client)
    end
end
