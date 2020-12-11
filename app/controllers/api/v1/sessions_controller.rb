module Api
  module V1
    class SessionsController < ApiController
      def create
        result = LoginUser.call(session_creating_params)

        if result.success?
          self.refresh_token = result.refresh_token
          render json: result.to_h.slice(:access_token)
        else
          render json: result.to_h.slice(:error), status: :unauthorized
        end
      end

      def update
        result = RefreshAuthentication.call(session_updating_params)

        if result.success?
          self.refresh_token = result.refresh_token
          render json: result.to_h.slice(:access_token)
        else
          render json: result.to_h.slice(:error), status: :unauthorized
        end
      end

      private

      def session_creating_params
        params.require(:session).permit(:email, :password)
      end

      def session_updating_params
        params.require(:session).permit(:access_token)
              .merge(refresh_token: request.cookies["refresh_token"])
      end

      def refresh_token=(value)
        response.set_cookie(:refresh_token, value: value, httponly: true)
      end
    end
  end
end
