class TimeEntriesController < ApplicationController
  before_action :set_time_entry, only: [:show, :edit, :update]

  def index
    @time_entries = TimeEntry.all
  end

  def new
    @time_entry = TimeEntry.new
  end

  def create
    time_entry = TimeEntry.new(time_entry_params)
    if time_entry.save
      redirect_to time_entry_path(time_entry)
    else
      redirect_to new_time_entry_path
    end
  end

  def edit
  end

  def update
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
      params.require(:time_entry).permit(:matter_id, :date, :duration, :description, :lawyer_id, :billable, :paid)
    end

    def set_time_entry
      @time_entry = TimeEntry.find_by(id: params[:id])
    end

end
