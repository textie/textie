class JwtService
  ALGORITHM = "HS256".freeze

  def initialize(secret = ENV.fetch("JWT_SECRET"))
    @secret = secret
  end

  def encode(payload)
    JWT.encode(payload, @secret, ALGORITHM)
  end

  def decode(token)
    JWT.decode(token, @secret, true, algorithm: ALGORITHM)[0]
  rescue JWT::DecodeError
    nil
  end
end
