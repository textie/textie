class ApplicationController < ActionController::API
  include Authentication

  before_action :authenticate_user!

  self.responder = ::ApiResponder
end
