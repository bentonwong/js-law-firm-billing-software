class SessionsController < ApplicationController
  before_action :authorized?, only: [:destroy]

  def home
    redirect_to matters_path if signed_in?
  end

  def new
    @error = nil
    @lawyer = Lawyer.new
  end

  def create
    if !params[:provider].nil?
      validate_oauth
    elsif params[:lawyer][:email].blank? || params[:lawyer][:password].blank?
      @error = 'ALERT: Email or password cannot be left blank!'
      redirect_to_signin_form_with_errors
    else
      validate_signin
    end
  end

  def destroy
    session.delete :lawyer_id
    redirect_to root_path
  end

end
