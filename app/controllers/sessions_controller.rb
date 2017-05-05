class SessionsController < ApplicationController
  def home
    if session[:user_id]
      redirect_to matters_path
    end
  end

  def new
  end

  def create
    if params[:user][:email].blank? || params[:user][:password].blank?
      redirect_to sessions_new_path
    else
      @lawyer = Lawyer.find_by(name: params[:user][:email])
      if !!@lawyer && @lawyer.authenticate(params[:user][:password])
        session[:user_id] = @lawyer.id
        redirect_to lawyer_path(@lawyer)
      else
        redirect_to signin_path
      end
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

end
