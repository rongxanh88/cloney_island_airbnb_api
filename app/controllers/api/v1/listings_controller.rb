class Api::V1::ListingsController < ApplicationController
  def show
    if request.headers[:Authorization]
      regex = /Bearer (.+)/
      jwt = request.headers[:Authorization].match(regex)[1]
      begin
        decoded_jwt = JWT.decode(
          jwt, ENV['hmac_secret'], true, { algorithm: 'HS256' }
        )
      rescue JWT::ExpiredSignature
        render json: {
          status: 401,
          message: "Access Token Expired."
        }.to_json
      end
      listing = Listing.find_by(user_id: decoded_jwt.first["user_id"])
      render json: listing
    else
      render json: {
        status: 400,
        message: "Authorization header not set."
      }.to_json
    end
  end
end
