class ClientsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record_handle

  def index
    clients = Client.all
    render json: clients
  end

  def show
    render json: find_client
  end

  def update
    client = find_client.update!(parameters)
    render json: client
  end

  private

  def parameters
    params.permit(:name, :age)
  end

  def find_client
    Client.find(params[:id])
  end

  def record_not_found
    render json: {errors: "Client not found"}, status: :not_found
  end

  def invalid_record_handle(invalid)
    render json: {errors: invalid.record.errors.full_message}, status: :unprocessable_entity
  end
end
