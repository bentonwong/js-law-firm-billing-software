class SessionsController < ApplicationController
  before_action :authorized?, only: [:destroy]

  def home
    if signed_in?
      redirect_to matters_path
    end
  end

  def new
    @error = nil
    @lawyer = Lawyer.new
  end

  def create
    if !params[:provider].nil?
      @lawyer = Lawyer.update_or_create(env["omniauth.auth"])
      if @lawyer
        session.clear
        session[:lawyer_id] = @lawyer.id
        redirect_to lawyer_path(@lawyer)
      else
        @error = 'Alert: Invalid credentials!'
        @lawyer = Lawyer.new
        render :new
      end
    elsif params[:lawyer][:email].blank? || params[:lawyer][:password].blank?
      @error = 'ALERT: Email or password cannot be left blank!'
      @lawyer = Lawyer.new
      render :new
    else
      @lawyer = Lawyer.find_by(email: params[:lawyer][:email])
      if !!@lawyer && @lawyer.authenticate(params[:lawyer][:password])
        session.clear
        session[:lawyer_id] = @lawyer.id
        redirect_to lawyer_path(@lawyer)
      else
        @error = 'ALERT: Email or password are incorrect!'
        @lawyer = Lawyer.new
        render :new
      end
    end
  end

  def destroy
    session.delete :lawyer_id
    redirect_to root_path
  end

end
