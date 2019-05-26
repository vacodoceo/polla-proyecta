class SessionsController < ApplicationController
  before_action :active_nav
  #before_action :set_session, only [:edit, :update, :destroy]

  def active_nav
    @active = "user"
  end

  def new
  end

  def edit
  end



  def create_google
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path
  end

  def create
    user = User.find_by_email(params['email'])
    if user.present?
      if user.password == params['password']
        session[:user_id] = user.id
        redirect_to root_path
      else
        redirect_to login_path, notice: 'Email o contraseña incorrectos, por favor intente nuevamente'
      end
    else
      redirect_to login_path, notice: 'Email o contraseña incorrectos, por favor intente nuevamente'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def update
  end

private
  def set_session
  end

  def session_params
    params.permit(:email, :password)
  end

end