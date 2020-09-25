class LoginUser
  class AuthenticateUser
    include Interactor

    delegate :email, :password, :user, to: :context

    def call
      context.user = User.find_by(email: email)&.authenticate(password)
      fail! unless user
    end

    private

    def fail!
      context.fail!(error: I18n.t("authenticate_user.failure"))
    end
  end
end
