class ApplicationController < ActionController::API
  def resource_name
    return controller_name if action_name == "index"

    controller_name.singularize
  end
end
