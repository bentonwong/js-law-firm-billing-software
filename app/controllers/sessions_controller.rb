class SessionsController < ApplicationController
  def home
    if session[:user_id]
      redirect_to attractions_path
    end
  end

  def new
  end

  def create
    if params[:user][:name].blank? || params[:user][:password].blank?
      redirect_to sessions_new_path
    else
      @user = User.find_by(name: params[:user][:name])
      if !!@user && @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
        redirect_to user_path(@user)
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
