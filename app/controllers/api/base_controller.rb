module Api
  class BaseController < ::ApplicationController
    self.responder = ::ApiResponder
    respond_to :json
  end
end
