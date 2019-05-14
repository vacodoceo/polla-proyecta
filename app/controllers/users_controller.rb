class UserssController < ApplicationController
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