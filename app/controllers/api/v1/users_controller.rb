module Api
  module V1
    class UsersController < ApiController
      expose :user

      def create
        if user.save
          render json: user, status: :created
        else
          render json: { errors: user.errors }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :full_name, :password)
      end
    end
  end
end
