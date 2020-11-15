class RefreshAuthentication
  class DestroyRefreshToken
    include Interactor

    delegate :refresh_token, to: :context

    def call
      refresh_token.destroy!
    end
  end
end
