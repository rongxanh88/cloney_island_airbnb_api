class Api::V1::ListingsController < ApplicationController
  def show
    requested_action = 'get_listing'
    result = JWTService.receive(request, requested_action)
    if result.resource
      render json: result.resource
    else
      render json: {status: result.status, message: result.message}
    end
  end

  def create
    result = JWTService.receive(request)
    if result.user_id
      Listing.create!(listing_params)
      render json: {status: 201, message: "Listing Created"}
    else
      render json: {status: result.status, message: result.message}
    end
  end

  def destroy
    result = JWTService.receive(request)
    if result.user_id
      Listing.destroy(params[:id])
      render json: {status: 202, message: "Listing Destroyed"}
    else
      render json: {status: result.status, message: result.message}
    end
  end

  private

    def listing_params
      params.require(:listing)
            .permit(
              :name, :description, :address, :accomodates, :bathrooms,
              :bedrooms, :beds, :price, :house_rules, :property_type,
              :bed_type, :pet_type, :room_type, :cancellation_policy,
              :status, :user_id
            )
    end
end
