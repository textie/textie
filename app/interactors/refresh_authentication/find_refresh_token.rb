class RefreshAuthentication
  class FindRefreshToken
    include Interactor

    delegate :refresh_token, to: :context

    def call
      fail!(error: "") unless payload

      context.refresh_token = RefreshToken.find(payload["id"])
      fail!(error: "") unless refresh_token
    end

    private

    def payload
      @payload ||= JwtService.new.decode(refresh_token)
    end
  end
end
