module ApplicationHelper

  def current_user
    @current_user ||= Lawyer.find_by(id: session[:lawyer_id]) if session[:lawyer_id]
  end

  def signed_in?
    !!current_user
  end

  def save_lawyer
    if @lawyer.save
      session.clear
      session[:lawyer_id] = @lawyer.id
      redirect_to lawyer_path(@lawyer)
    else
      render :new
    end
  end

  private

    def authorized?
      redirect_to root_path if !signed_in?
    end

end
