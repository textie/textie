module Api
  class ApiController < ApplicationController
    self.responder = ApiResponder
    respond_to :json
  end
end
