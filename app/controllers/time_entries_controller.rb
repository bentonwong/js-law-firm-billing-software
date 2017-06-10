class TimeEntriesController < ApplicationController
  before_action :set_matter
  before_action :set_time_entry, only: [:show, :edit, :update, :destroy]
  before_action :authorized?

  def index
    @time_entries = @matter.time_entries
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
    @client_name = name_of_client_by_time_entry
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
        redirect_to matter_time_entry_path(@matter, @time_entry)
      else
        render :new
      end
    end

    def name_of_client_by_time_entry
      Client.find(@time_entry.matter.client_id).name
    end

end
