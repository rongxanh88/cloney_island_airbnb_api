class JWTService
  attr_reader :status, :message, :listing, :jwt

  def initialize(authorization)
    if authorization
      @jwt = get_jwt(authorization)
      # begin
      #   decoded_jwt = JWT.decode(
      #     jwt, ENV['hmac_secret'], true, { algorithm: 'HS256' }
      #   )
      #   @listing = Listing.find_by(user_id: decoded_jwt.first["user_id"])
      # rescue JWT::ExpiredSignature
      #   expired_signature
      # end
      decode_jwt
    else
      header_not_set
    end
  end
  
  def self.response(request)
    JWTService.new(request.headers[:Authorization])
  end

  private

    def decode_jwt
      begin
        get_listing
      rescue JWT::ExpiredSignature
        expired_signature
      end
    end

    def get_jwt(bearer_token)
      regex = /Bearer (.+)/
      bearer_token.match(regex)[1]
    end

    def get_listing
        decoded_jwt = JWT.decode(
          jwt, ENV['hmac_secret'], true, { algorithm: 'HS256' }
        )
        @listing = Listing.find_by(user_id: decoded_jwt.first["user_id"])
    end

    def header_not_set
      @status = 400
      @message = "Authorization header not set."
    end

    def expired_signature
      @status = 401
      @message = "Access Token Expired."
    end
end