class ApiResponder < ActionController::Responder
  def api_behavior
    if get?
      render json: resource
    elsif post?
      render json: resource, status: :created
    elsif put? || patch? || delete?
      render json: resource, status: :ok
    else
      head :ok
    end
  end
end
