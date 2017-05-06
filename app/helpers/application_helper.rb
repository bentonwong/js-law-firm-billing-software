module ApplicationHelper

  def current_user
    @current_user ||= Lawyer.find_by(id: session[:lawyer_id]) if session[:lawyer_id]
  end

  def signed_in?
    !!current_user
  end

  private

    def authorized?
      redirect_to root_path if !signed_in?
    end

end
