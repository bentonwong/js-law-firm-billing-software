module ApplicationHelper

  def current_user
    @current_user ||= Lawyer.find_by(id: session[:lawyer_id]) if session[:lawyer_id]
  end

  def signed_in?
    !!current_user
  end

  def current_user_is(lawyer)
    current_user == lawyer
  end

  def matter_lawyer_exists?
    @matter.lawyer.nil?
  end

  def matter_notes_not_blank
    !@matter.notes.blank?
  end

  def display_billable_cost_of(time_entry)
    time_entry.billable? ? number_to_currency(time_entry.cost) : "(no charge)"
  end

  def billable_status_of(time_entry)
    time_entry.billable? ? "Yes" : "No"
  end

  def paid_status_of(time_entry)
    time_entry.paid? ? "Yes" : "No"
  end

  def new_lawyer_view_header
    signed_in? ? "Add a Lawyer" : "Lawyer Sign Up"
  end

  def matters_not_blank_for_this(lawyer)
    !lawyer.matters.blank?
  end

  private

    def authorized?
      redirect_to root_path if !signed_in?
    end

end
