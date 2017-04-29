class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update]

  def index
    @clients = Clients.all
  end

  def new
    @client = Client.new
  end

  def create
    client = Client.new(params)
    if client.save
      redirect_to client_path(client)
    else
      redirect_to new_client_path
    end
  end

  def edit
  end

  def update
    @client.update(params)
    redirect_to @client
  end

  def show
  end

  def destroy
  end

  private

    def client
      @client = Client.find_by(id: params[:id])
    end


end
