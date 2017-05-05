module ApplicationHelper

  def current_user
    Lawyer.find_by(id: session[:lawyer_id])
  end

  def signed_in?
    !!current_user
  end

end
