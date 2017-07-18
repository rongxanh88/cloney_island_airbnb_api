class Api::V1::ListingsController < ApplicationController
  def show
    # render json: JWTService.response(request)
    response = JWTService.response(request)
    if response.listing
      render json: response.listing
    else
      render json: {status: response.status, message: response.message}
    end
    # if request.headers[:Authorization]
    #   jwt = get_jwt(request)
    #   begin
    #     render json: Listing.return_from_jwt(jwt)
    #   rescue JWT::ExpiredSignature
    #     render json: expired_signature
    #   end
    # else
    #   render json: header_not_set
    # end
  end

  def create

  end

  # private
  #   def get_jwt(request)
  #     regex = /Bearer (.+)/
  #     request.headers[:Authorization].match(regex)[1]
  #   end

  #   def header_not_set
  #     {status: 400, message: "Authorization header not set."}
  #   end

  #   def expired_signature
  #     {status: 401, message: "Access Token Expired."}
  #   end
end
