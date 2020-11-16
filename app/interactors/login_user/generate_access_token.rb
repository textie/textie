class LoginUser
  class GenerateAccessToken
    include Interactor

    delegate :user, to: :context

    def call
      context.access_token = JwtService.new.encode(payload)
    end

    private

    def payload
      {
        sub: user.id,
        iat: unix_time
      }
    end

    def unix_time
      Time.current.utc.to_i
    end
  end
end
