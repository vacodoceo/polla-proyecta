class UsersController < ApplicationController
    before_action :active_nav
    before_action :set_user, only: [:edit, :update, :destroy]
    before_action :verify_admin, only: [:index, :destroy]
    def active_nav
        @active = "user"
    end

    def index
      @users = User.all
    end

    def new
        @user = User.new
    end

    def edit
      @user = User.find(params[:id])
      if current_user.id != @user.id && !current_user.is_admin
        redirect_to root_path
      end
    end

    def create
      if params['password'] == params['password_confirmation']
        if params['password'].length > 5
          if params['phone_number'].start_with?('+569') && params['phone_number'].length == 12
            @user = User.create(user_params)
            puts params
            @user.name = params['first_name'] + ' ' + params['last_name']
            if @user.save          
              session[:user_id] = @user.id
              redirect_to root_path
            else
              render :new
            end

          else
            redirect_to register_path, notice: 'El formato del teléfono ingresado no es válido'
          end
        else
          redirect_to register_path, notice: 'La contraseña debe tener al menos 6 caracteres'
        end
      else
        redirect_to register_path, notice: 'Las contraseñas no coinciden'
      end
    end

    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to root_path}
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def update_credits
      puts "================"
      puts params
      @user = User.find(params[:id])
      @user.update(credits: params[:user][:credits])
      redirect_to users_path
    end
  
    # DELETE /pollas/1
    # DELETE /pollas/1.json
    def destroy
      @transactions = Transaction.where(:user_id => @user.id)
      @transactions.each do |trans|
        trans.user_id = 1
        trans.save
      end
      @user.destroy
      respond_to do |format|
        format.html { redirect_to root_path}
        format.json { head :no_content }
      end
    end

    private
    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.permit(:password, :email, :phone_number)
    end

    def verify_user
      if !current_user
        redirect_to login_path, notice: 'Debes estar logeado para poder acceder a las funciones de la página'
      end
    end

    def verify_admin
      if !current_user || !current_user.is_admin
        redirect_to root_path
      end
    end

end