class Api::V1::ListingsController < ApplicationController
  def show
    requested_resource = 'listing'
    result = JWTService.receive(request, requested_resource)
    if result.resource
      render json: result.resource
    else
      render json: {status: result.status, message: result.message}
    end
  end

  def create
    
  end
end
