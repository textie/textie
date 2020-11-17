class LoginUser
  class GenerateJwt
    include Interactor

    delegate :user, to: :context

    def call
      context.token = JwtService.new.encode(payload)
    end

    private

    def payload
      { id: user.id }
    end
  end
end
