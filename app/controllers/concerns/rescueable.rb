module Rescueable
  def render_errors(status, message)
    render json: { error: message }, status: status
  end

  def self.included(base)
    base.rescue_from(Errors::Unauthorized) do
      render_errors(:unauthorized, 'unauthorized')
    end
  end
end