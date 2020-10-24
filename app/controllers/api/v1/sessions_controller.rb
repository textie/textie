module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :authenticate_user!, only: %i[create]

      def create
        result = LoginUser.call(session_params)

        if result.success?
          render json: { token: result.token }
        else
          render json: { error: result.error }, status: :unauthorized
        end
      end

      private

      def session_params
        params.permit(:email, :password)
      end
    end
  end
end
