class ApplicationController < ActionController::API

  def require_login
    render json: { message: 'Access denied' }, status: :unprocessable_entity unless authenticate_token
  end
  
  def current_user
    @current_user ||= authenticate_token
  end

  # def render_unauthorized(message)
  #   render json: message, status: :unauthorized
  # end

  private
  def authenticate_token
    token = request.headers['Authorization']
    CompanyAdmin.find_by(token: token)
  end
end