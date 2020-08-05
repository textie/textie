class JwtCodec
  def initialize(secret = ENV.fetch("JWT_SECRET"))
    @secret = secret
  end

  def encode(payload)
    JWT.encode(payload, @secret)
  end

  def decode(token)
    JWT.decode(token, @secret, true, algorithm: "HS256")[0]
  rescue JWT::DecodeError
    nil
  end
end
