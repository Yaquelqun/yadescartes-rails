class ApplicationController < ActionController::API
  skip_before_action :verify_authenticity_token

  def current_user
    @current_user ||= begin
      email = extract_user_from_headers
      User.find_by!(email: email)
    end
  end

  private

  def extract_user_from_headers
    pattern = /^Bearer /
    header  = request.headers['Authorization']
    header.gsub(pattern, '') if header&.match(pattern)
  end
end

