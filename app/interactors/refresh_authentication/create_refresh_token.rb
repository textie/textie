class RefreshAuthentication
  class CreateRefreshToken
    include Interactor

    delegate :user, to: :context

    def call
      refresh_token = RefreshToken.create(user: user)

      context.refresh_token = JwtService.new.encode(id: refresh_token.id)
    end
  end
end
