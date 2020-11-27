class RecognizeUser
  include Interactor

  TOKEN_LIFETIME = 1.hour

  delegate :token, to: :context

  def call
    fail!("expired") if jwt_expired?

    context.user = User.find(payload["sub"])
  end

  private

  def jwt_expired?
    fail!("invalid_token") unless payload && payload.key?("iat")

    Time.at(payload["iat"]).utc < TOKEN_LIFETIME.ago
  end

  def payload
    @payload ||= JwtService.new.decode(token)
  end

  def fail!(error_code)
    context.fail!(error: I18n.t("authenticate.#{error_code}"))
  end
end
