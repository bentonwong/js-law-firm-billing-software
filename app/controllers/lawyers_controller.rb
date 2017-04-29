class LawyersController < ApplicationController
  before_action :set_lawyer, only: [:show, :edit, :update]

  def index
    @lawyers = Lawyers.all
  end

  def new
    @lawyer = Lawyer.new
  end

  def create
    lawyer = Lawyer.new(params)
    if lawyer.save
      redirect_to lawyer_path(lawyer)
    else
      redirect_to new_lawyer_path
    end
  end

  def edit
  end

  def update
    @lawyer.update(params)
    redirect_to @lawyer
  end

  def show
  end

  def destroy
  end

  private

    def client
      @lawyer = Lawyer.find_by(id: params[:id])
    end

end
