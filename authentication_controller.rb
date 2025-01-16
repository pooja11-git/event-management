module Users
    class AuthenticationController < ApplicationController
      skip_before_action :authorize_request, only: %i[signup login]
  
      def signup
        user = User.new(user_params)
        if user.save
          render json: { token: JsonWebToken.encode(user_id: user.id) }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end
  
      def login
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
          render json: { token: JsonWebToken.encode(user_id: user.id) }, status: :ok
        else
          render json: { errors: ['Invalid email or password'] }, status: :unauthorized
        end
      end
  
      private
  
      def user_params
        params.require(:users).permit(:name, :email, :password, :password_confirmation, :role)
      end
    end
  end
  