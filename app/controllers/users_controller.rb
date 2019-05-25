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
        #@user.name = params['firstName'] + params['LastName']
        #@user.oauth_token = '-1'
        #@user.phone_number = params['PhoneNumber']
        redirect_to index_path
    end

    private

    def user_params
        #params.require(:user).permit(:firstName, :password, :email, :LastName, :PhoneNumber)
        continue
    end
end