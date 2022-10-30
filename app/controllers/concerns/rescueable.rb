module Rescueable
  def render_errors(status, message)
    render json: { error: message }, status: status
  end

  def self.included(base)
    base.rescue_from(Errors::Unauthorized) do
      render_errors(:unauthorized, 'unauthorized')
    end

    base.rescue_from(Errors::ApplicationError) do |error|
      render_errors(error.status, error.message)
    end

    base.rescue_from(ActiveRecord::RecordNotFound) do |error|
      render_errors(:not_found, "#{error.model.parameterize.underscore}_not_found")
    end
  end
end

