class GymsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record_handle

  def index
    gyms = Gym.all
    render json: gyms
  end

  def show
    render json: find_gym
  end

  def destroy
    find_gym.destroy
    render json: {}, status: :ok
  end

  def update
    gym = find_gym.update!(parameters)
    render json: gym
  end

  private

  def parameters
    params.permit(:name, :address)
  end
  
  def find_gym
    Gym.find(params[:id])
  end

  def record_not_found
    render json: {errors: "Gym not found"}, status: :not_found
  end

  def invalid_record_handle(invalid)
    render json: {errors: invalid.record.errors.full_message}, status: :unprocessable_entity
  end

end
