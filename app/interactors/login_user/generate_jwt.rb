class LoginUser
  class GenerateJwt
    include Interactor

    delegate :user, to: :context

    def call
      context.token = JwtCodec.new.encode(user_attributes)
    end

    private

    def user_attributes
      {
        id: user.id,
        email: user.email,
        full_name: user.full_name
      }
    end
  end
end
