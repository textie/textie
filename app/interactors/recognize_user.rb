class RecognizeUser
  include Interactor

  TOKEN_LIFETIME = 1.hour

  delegate :token, to: :context

  def call
    fail!("invalid_token") unless payload
    fail!("expired") if jwt_expired?

    context.user = User.find(payload["sub"])
  end

  private

  def payload
    @payload ||= JwtService.new.decode(token)
  end

  def fail!(error_code)
    context.fail!(error: I18n.t("authenticate.#{error_code}"))
  end

  def jwt_expired?
    Time.utc(payload["iat"]) < TOKEN_LIFETIME.ago
  end
end
