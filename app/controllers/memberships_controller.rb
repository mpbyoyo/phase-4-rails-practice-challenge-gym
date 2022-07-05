class MembershipsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record_handle

  def create
    mem = Membership.create!(parameters)
    render json: mem, status: :created
  end

  private

  def parameters
    parmas.permit(:charge, :client_id, :gym_id)
  end

  def invalid_record_handle(invalid)
    render json: {errors: invalid.record.errors.full_message}, status: :unprocessable_entity
  end
end
