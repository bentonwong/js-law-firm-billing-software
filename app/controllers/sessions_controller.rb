class SessionsController < ApplicationController
  before_action :authorized?, only: [:destroy]

  def home
    redirect_to current_user if signed_in?
  end

  def new
    redirect_to current_user if signed_in?
    @error = nil
    @lawyer = Lawyer.new
  end

  def create
    if !params[:provider].nil?
      validate_oauth
    elsif params[:lawyer][:email].blank? || params[:lawyer][:password].blank?
      redirect_to_signin_form_with_errors('ALERT: Email or password cannot be left blank!')
    else
      validate_signin
    end
  end

  def destroy
    session.delete :lawyer_id
    redirect_to root_path
  end

  private

    def validate_oauth
      @lawyer = Lawyer.update_or_create(env["omniauth.auth"])
      if @lawyer
        start_new_session
      else
        redirect_to_signin_form_with_errors('Alert: Unable to login with those credentials!')
      end
    end

    def validate_signin
      @lawyer = Lawyer.find_by(email: params[:lawyer][:email])
      if !!@lawyer && @lawyer.authenticate(params[:lawyer][:password])
        start_new_session
      else
        redirect_to_signin_form_with_errors('ALERT: Email and/or password are incorrect!')
      end
    end

    def start_new_session
      session.clear
      session[:lawyer_id] = @lawyer.id
      redirect_to @lawyer
    end

    def redirect_to_signin_form_with_errors(msg)
      @error = msg
      @lawyer = Lawyer.new
      render :new
    end

end
