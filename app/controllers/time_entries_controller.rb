class TimeEntriesController < ApplicationController
  before_action :set_time_entry, only: [:show, :edit]

  def index
    @time_entries = TimeEntry.all
  end

  def new
    @time_entry = TimeEntry.new
  end

  def create
    time_entry = TimeEntry.new(params)
    if time_entry.save
      redirect_to time_entry_path(time_entry)
    else
      redirect_to new_time_entry_path
    end
  end

  def edit
  end

  def update
    @time_entry.update(params)
    redirect_to @time_entry
  end

  def show
  end

  def destroy
  end

  private

    def set_time_entry
      @time_entry = TimeEntry.find_by(id: params[:id])
    end

end
