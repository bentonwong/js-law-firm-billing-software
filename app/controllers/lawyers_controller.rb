class LawyersController < ApplicationController
  before_action :set_lawyer, only: [:show, :edit, :update]

  def index
    @lawyers = Lawyer.all
  end

  def new
    @lawyer = Lawyer.new
  end

  def create
    @lawyer = Lawyer.new(lawyer_params)
    if @lawyer.save
      session[:lawyer_id] = @lawyer.id
      redirect_to lawyer_path(@lawyer)
    else
      render :new
    end
  end

  def edit
    if session[:lawyer_id] != params[:id]
      redirect_to lawyer_path(current_user)
    end
  end

  def update
    @lawyer.update(lawyer_params)
    redirect_to @lawyer
  end

  def show
  end

  def destroy
  end

  private

    def lawyer_params
      params.require(:lawyer).permit(:name, :email, :password, :rate)
    end

    def set_lawyer
      @lawyer = Lawyer.find_by(id: params[:id])
    end

end
