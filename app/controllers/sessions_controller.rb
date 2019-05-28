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

  def recover
  end

  def new_password
  end

  def change_password
    if params['password'] == params['confirm_password']
      @user = User.find(params[:id])
      puts @user.email
      puts @user.name
      @user.password = params['password']
      @user.save
      redirect_to login_path, notice: 'Contraseña cambiada exitosamente'
    else
      redirect_to new_password_path(@user), notice: "Las contraseñas no coinciden"
    end
  end

  def recover_password
    if params['email'] == params['confirm_email']
      @user = User.find_by_email(params['email'])
      if @user
        UserMailer.recover_password(@user).deliver_now
        redirect_to login_path, notice: "Se ha enviado un mail para restablecer la contraseña, si no lo encuentra revise en su carpeta de spam"
      else
        redirect_to recover_password_path, notice: "El email ingresado no pertenece a ningún usuario"
      end
    else 
      redirect_to recover_password_path, notice: "Los emails no coinciden"
    end
  end

  def create_google
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path
  end

  def create
    user = User.find_by_email(params['email'])
    if user && user.authenticate(params['password'])
        session[:user_id] = user.id
        redirect_to root_path
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