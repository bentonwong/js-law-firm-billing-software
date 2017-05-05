class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :invoice]
  before_action :authorized?

  def index
    @clients = Client.all
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to client_path(@client)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @client.update(client_params)
    redirect_to @client
  end

  def show
  end

  def invoice
  end

  def destroy
  end

  private

    def client_params
      params.require(:client).permit(:name, :email, :address, :phone)
    end

    def set_client
      @client = Client.find_by(id: params[:id])
    end

end
