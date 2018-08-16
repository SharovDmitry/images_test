class ApplicationController < ActionController::API
  before_action :check_auth_token

  private

  def current_user
    token = request.headers['auth-token']
    @current_user ||= User.find_by(auth_token: token) if token
  end

  def check_auth_token
    return if current_user
    head :unauthorized
  end

  def render_error(resource, status)
    render json: resource, status: status, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer
  end
end
