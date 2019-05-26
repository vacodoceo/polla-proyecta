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

  def create_normal
    puts "parametros"
    puts params
    user = User.find_by_email(params['email'])
    puts "user"
    puts user.name
    puts user.email
    puts user.password
    if user.present?
      if user.password == params['password']
        session[:user_id] = user.id
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

private
  def session_params
    params.permit(:email, :password)
  end

end