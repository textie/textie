module Api
  class AuthorizedApiController < AuthenticatedApiController
    include ActionPolicy::Controller

    authorize :user, through: :current_user
    verify_authorized

    # authorize exposed resource that matches controller name
    before_action :authorize_resource!

    def self.skip_authorization(only:)
      skip_verify_authorized only: only
      skip_before_action :authorize_resource!, only: only
    end

    def authorize_resource!
      authorize! send(resource_name)
    end
  end
end
