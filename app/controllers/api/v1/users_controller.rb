module Api::V1
  class UsersController < ApiController
    protect_from_forgery with: :null_session
    before_action :authenticate_user, except: [:create]

    def create
      @user = User.new(user_params)

      if @user.save
        render json: @user
      else
        render json: @user.errors
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password)
    end
  end
end
