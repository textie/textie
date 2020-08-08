class LoginUser
  class AuthenticateByPassword
    include Interactor

    delegate :user, :password, to: :context

    def call
      context.user = user.authenticate(password)
      fail! unless user
    end

    private

    def fail!
      context.fail!(error: I18n.t("error.invalid_credentails"))
    end
  end
end
