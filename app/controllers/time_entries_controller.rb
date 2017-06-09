class TimeEntriesController < ApplicationController
  before_action :set_time_entry, only: [:show, :edit, :update, :destroy]
  before_action :authorized?

  def index
    @time_entries = TimeEntry.all
  end

  def new
    @time_entry = TimeEntry.new
    @matter = Matter.find_by(id: params[:id]) if params[:id]
  end

  def create
    binding.pry
    @time_entry = TimeEntry.new(time_entry_params)
    set_rate_and_save
  end

  def edit
    @lawyer = @time_entry.matter.lawyer
  end

  def update
    @time_entry.assign_attributes(time_entry_params)
    set_rate_and_save
  end

  def show
    @client_name = name_of_client_by_time_entry
  end

  def destroy
    @time_entry.destroy
    redirect_to time_entries_path
  end

  private

    def time_entry_params
      params.require(:time_entry).permit(:matter_id, :date, :duration, :description, :lawyer_id, :rate, :billable, :paid)
    end

    def set_time_entry
      @time_entry = TimeEntry.find_by(id: params[:id])
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
        redirect_to @time_entry
      else
        render :new
      end
    end

    def name_of_client_by_time_entry
      Client.find(@time_entry.matter.client_id).name
    end

end
