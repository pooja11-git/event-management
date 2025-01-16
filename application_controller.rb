class ApplicationController < ActionController::API
    before_action :authorize_request
  
    attr_reader :current_user
  
    private
  
    def authorize_request
      header = request.headers['Authorization']
      token = header.split(' ').last if header
      decoded = JsonWebToken.decode(token)
      @current_user = User.find(decoded[:user_id]) if decoded
    rescue
      render json: { errors: ['Unauthorized access'] }, status: :unauthorized
    end
  
    def admin_only
      render json: { errors: ['Access denied'] }, status: :forbidden unless current_user&.role == 'admin'
    end
  end
  