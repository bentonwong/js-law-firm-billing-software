class SessionsController < ApplicationController
  before_action :authorized?, except: [:new, :home]

  def home
    if session[:user_id]
      redirect_to matters_path
    end
  end

  def new
    @lawyer = Lawyer.new
  end

  def create
    if params[:lawyer][:email].blank? || params[:lawyer][:password].blank?
      render :new
    else
      @lawyer = Lawyer.find_by(email: params[:lawyer][:email])
      if !!@lawyer && @lawyer.authenticate(params[:lawyer][:password])
        session[:lawyer_id] = @lawyer.id
        redirect_to lawyer_path(@lawyer)
      else
        render :new
      end
    end
  end

  def destroy
    session.delete :lawyer_id
    redirect_to root_path
  end

end
