module Api
  module V1
    class ProfilesController < AuthenticatedController
      def show
        render "api/v1/users/show", locals: { user: current_user }
      end
    end
  end
end
