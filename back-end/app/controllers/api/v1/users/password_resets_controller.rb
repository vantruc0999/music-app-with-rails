class Api::V1::Users::PasswordResetsController < ApiController
    skip_before_action :doorkeeper_authorize!, only: %i[forgot reset]

    def forgot
        if params[:email].blank?
          return render json: {error: 'Email not present'}
        end
    
        user = User.find_by(email: params[:email].downcase)
        if user.present?
          user.generate_password_token!
          url = 'http://127.0.0.1:3000/api/v1/users/password/reset/' + user.reset_password_token
          PasswordResetMailer.with(user: user, url: url).password_reset.deliver_later
          render json: {status: 'ok'}, status: :ok
        else
          render json: {error: ['Email address not found. Please check and try again.']}, status: :not_found
        end
      end
    
      def reset
        token = params[:token].to_s
    
        # if params[:email].blank?
        #   return render json: {error: 'Token not present'}
        # end
    
        user = User.find_by(reset_password_token: token)
    
        if user.present? && user.password_token_valid?
          if user.reset_password!(params[:password])
            render json: {status: 'ok'}, status: :ok
          else
            render json: {error: user.errors.full_messages}, status: :unprocessable_entity
          end
        else
          render json: {error:  ['Link not valid or expired. Try generating a new link.']}, status: :not_found
        end
      end
end
