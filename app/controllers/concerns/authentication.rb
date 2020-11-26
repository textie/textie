module Authentication
  extend ActiveSupport::Concern

  attr_reader :current_user

  def authenticate_user!
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
