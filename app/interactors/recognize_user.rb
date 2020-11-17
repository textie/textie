class RecognizeUser
  include Interactor

  delegate :token, to: :context

  def call
    payload = JwtService.new.decode(token)
    fail! unless payload
    context.user = User.find(payload["id"])
  end

  private

  def fail!
    context.fail!(error: I18n.t("authenticate.invalid_token"))
  end
end
