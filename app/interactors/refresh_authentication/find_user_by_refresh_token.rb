class RefreshAuthentication
  class FindUserByRefreshToken
    include Interactor

    delegate :refresh_token, to: :context

    # TODO: add error explanation
    def call
      fail!("invalid_token") if payload.nil?

      refersh_token = RefreshToken.destroy(payload["id"])
      fail!("expired") if refersh_token.expired?

      context.user = refersh_token.user
    rescue ActiveRecord::RecordNotFound
      fail!("invalid_token")
    end

    private

    def payload
      @payload ||= JwtService.new.decode(refresh_token)
    end

    def fail!(error_code)
      context.fail!(error: I18n.t("authenticate.#{error_code}"))
    end
  end
end
