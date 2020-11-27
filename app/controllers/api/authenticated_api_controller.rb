module Api
  class AuthenticatedApiController < ApiController
    attr_reader :current_user

    before_action :authenticate_user

    def authenticate_user
      authentication = RecognizeUser.call(token: auth_token)

      if authentication.success?
        @current_user = authentication.user
      else
        render json: { error: authentication.error }, status: :unauthorized
      end
    end

    def auth_token
      request.headers["Authorization"]&.split&.last
    end
  end
end
