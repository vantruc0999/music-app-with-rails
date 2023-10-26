class Api::V1::Users::UsersController < ApiController
    before_action :set_user, only: %i[ get_user update_user]
    skip_before_action :doorkeeper_authorize!, only: %i[ get_all_users ]
    before_action :is_login?, only: %i[ get_user update_user]

    include ApplicationHelper
    include ApiResponse

    def get_user
        data = @user.as_json(
            except: [:created_at, :updated_at],  # Specify the attributes to exclude without square brackets
            methods: [:avatar_image_url]
        )
        render_success(data, 'User load successfully')
    end

    def get_all_users
        render_success(User.all, 'Users load successfully')
    end

    def update_user
        if @user.update(user_params)
            render_success(@user, 'User information updated successfully')
        else
            render_error(@user.errors)
        end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = current_user
      end
  
      # Only allow a list of trusted parameters through.
      def user_params
        params.permit(:full_name, :birth_day, :gender, :avatar_image)
      end
end
