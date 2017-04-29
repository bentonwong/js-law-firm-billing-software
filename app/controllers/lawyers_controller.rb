class LawyersController < ApplicationController
  def index
    @lawyers = Lawyer.all
  end

  def new
    @lawyer = Lawyer.new
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
end
