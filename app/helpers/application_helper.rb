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

  def save_matter
    if @matter.save
      redirect_to @matter
    else
      render :new
    end
  end

  def update_matter
    if @matter.update(matter_params)
      redirect_to @matter
    else
      redirect_to edit_matter_path(@matter)
    end
  end

  def set_atty_rate
    @time_entry.rate = Lawyer.current_rate(time_entry_params[:lawyer_id])
  end

  def save_time_entry
    if @time_entry.save
      redirect_to time_entry_path(@time_entry)
    else
      render :new
    end
  end

  def save_client
    if @client.save
      redirect_to client_path(@client)
    else
      render :new
    end
  end

  def start_new_session
    session.clear
    session[:lawyer_id] = @lawyer.id
    redirect_to lawyer_path(@lawyer)
  end

  def redirect_to_signin_form_with_errors
    @lawyer = Lawyer.new
    render :new
  end

  def validate_oauth
    @lawyer = Lawyer.update_or_create(env["omniauth.auth"])
    if @lawyer
      start_new_session
    else
      @error = 'Alert: Invalid credentials!'
      redirect_to_signin_form_with_errors
    end
  end

  def validate_signin
    @lawyer = Lawyer.find_by(email: params[:lawyer][:email])
    if !!@lawyer && @lawyer.authenticate(params[:lawyer][:password])
      start_new_session
    else
      @error = 'ALERT: Email or password are incorrect!'
      redirect_to_signin_form_with_errors
    end
  end

  private

    def authorized?
      redirect_to root_path if !signed_in?
    end

end
