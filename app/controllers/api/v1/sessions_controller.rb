module Api
  module V1
    class SessionsController < ApiController
      def create
        result = LoginUser.call(session_creating_params)

        if result.success?
          render json: result.to_h.slice(:access_token, :refresh_token)
        else
          render json: result.to_h.slice(:error), status: :unauthorized
        end
      end

      def update
        result = RefreshAuthentication.call(session_updating_params)

        if result.success?
          render json: result.to_h.slice(:access_token, :refresh_token)
        else
          render json: result.to_h.slice(:error), status: :unauthorized
        end
      end

      private

      def session_creating_params
        params.require(:session).permit(:email, :password)
      end

      def session_updating_params
        params.require(:session).permit(:access_token, :refresh_token)
      end
    end
  end
end
