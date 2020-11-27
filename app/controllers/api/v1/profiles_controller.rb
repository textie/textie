module Api
  module V1
    class ProfilesController < AuthenticatedApiController
      def show
        respond_with current_user
      end
    end
  end
end
