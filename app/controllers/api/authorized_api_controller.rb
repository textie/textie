module Api
  class AuthorizedApiController < AuthenticatedApiController
    include ActionPolicy::Controller

    authorize :user, through: :current_user

    verify_authorized

    before_action :authorize_resource!

    def self.skip_authorization(only:)
      skip_verify_authorized only: only
      skip_before_action :authorize_resource!, only: only
    end

    def authorize_resource!
      authorize! self.send(resource_name)
    end

    def resource_name
      return controller_name if action_name == "index"

      controller_name.singularize
    end
  end
end
