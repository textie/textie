module Api
  module V1
    class ProfilesController < AuthenticatedController
      def show
        respond_with current_user
      end
    end
  end
end
