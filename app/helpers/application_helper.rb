module ApplicationHelper

  def current_user
    @current_user ||= Lawyer.find_by(id: session[:lawyer_id]) if session[:lawyer_id]
  end

  def signed_in?
    !!current_user
  end

  def current_user_is_lawyer
    current_user == @lawyer
  end

  def new_lawyer_view_header
    signed_in? ? "Add a Lawyer" : "Lawyer Sign Up"
  end

  private

    def authorized?
      redirect_to root_path if !signed_in?
    end

end
