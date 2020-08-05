class RecognizeUser
  class AuthenticateByJwt
    include Interactor

    delegate :token, to: :context

    def call
      user_attributes = JwtCodec.new.decode(token)
      fail! unless user_attributes
      context.user = User.new(user_attributes)
    end

    private

    def fail!
      context.fail!(error: I18n.t("error.invalid_jwt"))
    end
  end
end
