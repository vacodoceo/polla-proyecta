class SessionsController < ApplicationController
  before_action :active_nav
  def active_nav
    @active = "user"
  end
  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path
  end

  #def create_normal
   # user = User.find_by_email(session_params['email'])
    #if user
     # if user.password == session_params['password']
      #  session[:user_id] = user.id
       # redirect_to root_path
   #   end
    #end
    #redirect_to login_path
  #end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

 # def session_params
  #  params.permit(:email, :password)
  #end
end