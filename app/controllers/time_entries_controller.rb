class TimeEntriesController < ApplicationController
  before_action :set_matter
  before_action :set_time_entry, only: [:show, :edit, :update, :destroy]
  before_action :authorized?

  def index
    @time_entries = @matter.time_entries
    respond_to do |format|
      format.html {render :index}
      format.json {render json: @time_entries}
    end
  end

  def new
    @time_entry = @matter.time_entries.build
  end

  def create
    @time_entry = @matter.time_entries.build(time_entry_params)
    set_rate_and_save
  end

  def edit
    @lawyer = @matter.lawyer
  end

  def update
    @time_entry.assign_attributes(time_entry_params)
    set_rate_and_save
  end

  def show
    @client = find_client_by_matter_client_id
    respond_to do |format|
      format.html {render :show}
      format.json {render json: @time_entry}
    end
  end

  def destroy
    @time_entry.destroy
    redirect_to matter_time_entries_path
  end

  private

    def time_entry_params
      params.require(:time_entry).permit(:matter_id, :date, :duration, :description, :lawyer_id, :rate, :billable, :paid)
    end

    def set_matter
      @matter = Matter.find_by(id: params[:matter_id])
    end

    def set_time_entry
      @time_entry = @matter.time_entries.find_by(id: params[:id])
    end

    def set_rate_and_save
      set_atty_rate if !time_entry_params[:lawyer_id].blank?
      save_time_entry
    end

    def set_atty_rate
      @time_entry.rate ||= Lawyer.current_rate(time_entry_params[:lawyer_id])
    end

    def save_time_entry
      if @time_entry.save
        respond_to do |format|
          format.html {render :show}
          format.json {render json: @time_entry}
        end
      else
        respond_to do |format|
          format.html {render :new}
          format.json {render :error, :layout => false}
        end
      end
    end

    def find_client_by_matter_client_id
      Client.find_by(id: @matter.client_id)
    end

end
