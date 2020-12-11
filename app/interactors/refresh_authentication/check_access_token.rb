class RefreshAuthentication
  class CheckAccessToken
    include Interactor

    delegate :access_token, :user, to: :context

    def call
      fail! if payload["sub"] != user.id
    end

    private

    def payload
      @payload ||= JwtService.new.decode(access_token)
    end

    def fail!
      context.fail!(error: I18n.t("authenticate.invalid_token"))
    end
  end
end
