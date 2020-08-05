class LoginUser
  class FindUserByEmail
    include Interactor

    delegate :email, to: :context

    def call
      context.user = User.find_by(email: email)
      fail! unless context.user
    end

    private

    def fail!
      context.fail!(error: I18n.t("error.user_not_found", email: email))
    end
  end
end
