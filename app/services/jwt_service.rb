class JWTService
  attr_reader :status, :message, :resource, :jwt, :user_id

  def initialize(authorization)
    if authorization
      decode_jwt(authorization)
    else
      header_not_set
    end
  end
  
  def self.receive(request)
    JWTService.new(request.headers[:Authorization])
  end

  private
    def decode_jwt(authorization)
      begin
        jwt = get_jwt(authorization)
        @jwt = JWT.decode(
          jwt, ENV['hmac_secret'], true, { algorithm: 'HS256' }
        )
        set_user
      rescue JWT::ExpiredSignature
        expired_signature
      end
    end

    def get_jwt(bearer_token)
      regex = /Bearer (.+)/
      bearer_token.match(regex)[1]
    end

    def set_user
      @user_id = @jwt.first["user_id"]
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