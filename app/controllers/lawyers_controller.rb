class LawyersController < ApplicationController
  before_action :set_lawyer, only: [:show, :edit, :update, :destroy]
  before_action :authorized?, except: [:new, :create]

  def index
    @lawyers = Lawyer.all
    respond_to do |f|
      f.html { render :index }
      f.json { render json: @lawyers }
    end
  end

  def new
    @lawyer = Lawyer.new
  end

  def create
    @lawyer = Lawyer.new(lawyer_params)
    save_lawyer
  end

  def edit
    redirect_to lawyer_path(current_user) if session[:lawyer_id] != params[:id].to_i
  end

  def update
    @lawyer.update(lawyer_params)
    redirect_to @lawyer
  end

  def show
    respond_to do |format|
      format.html {render :show}
      format.json {render json: @lawyer}
    end
  end

  private

    def lawyer_params
      params.require(:lawyer).permit(:name, :email, :password, :password_confirmation, :rate)
    end

    def set_lawyer
      @lawyer = Lawyer.find_by(id: params[:id])
      if !@lawyer
        redirect_to lawyers_path
      end
    end

    def save_lawyer
      if @lawyer.save
        if !signed_in?
          session.clear
          session[:lawyer_id] = @lawyer.id
        end
        redirect_to @lawyer
      else
        render :new
      end
    end

end
