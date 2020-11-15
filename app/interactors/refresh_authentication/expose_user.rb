class RefreshAuthentication
  class ExposeUser
    include Interactor

    delegate :refresh_token, to: :context

    def call
      context.user = refresh_token.user
    end
  end
end
