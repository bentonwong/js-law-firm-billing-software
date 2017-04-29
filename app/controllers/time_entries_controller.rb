class TimeEntriesController < ApplicationController
  before_action :set_time_entry, only: [:show, :edit]

  def index
    @time_entries = TimeEntry.all
  end

  def new
    @time_entry = TimeEntry.new
  end

  def create
  end

  def edit
  end

  def update
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
