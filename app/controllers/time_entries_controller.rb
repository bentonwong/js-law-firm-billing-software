class TimeEntriesController < ApplicationController
  before_action :set_time_entry, only: [:show, :edit, :update]
  before_action :authorized?

  def index
    @time_entries = TimeEntry.all
  end

  def new
    @time_entry = TimeEntry.new
    @matter = Matter.find_by(id: params[:id]) if params[:id]
  end

  def create
    @time_entry = TimeEntry.new(time_entry_params)
    set_atty_rate
    save_time_entry
  end

  def edit
  end

  def update
    set_atty_rate
    @time_entry.update(time_entry_params)
    redirect_to @time_entry
  end

  def show
    @client_name = Client.find(@time_entry.matter.client_id).name
  end

  def destroy
  end

  private

    def time_entry_params
      params.require(:time_entry).permit(:matter_id, :date, :duration, :description, :lawyer_id, :rate, :billable, :paid)
    end

    def set_time_entry
      @time_entry = TimeEntry.find_by(id: params[:id])
    end

    def set_atty_rate
      @time_entry.rate = Lawyer.current_rate(time_entry_params[:lawyer_id])
    end

end
