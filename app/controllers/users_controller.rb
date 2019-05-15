class UsersController < ApplicationController
    before_action :active_nav
    def active_nav
        @active = "user"
    end
    def new
        @user = User.new
    end

    def create
        user = User.create(user_params)

        redirect_to index_path
    end

    private

    def user_params
    # params.require(:user).permit(:name, :password, :email)
    continue        
    end
end