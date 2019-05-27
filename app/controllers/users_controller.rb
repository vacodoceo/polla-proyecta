class UsersController < ApplicationController
    before_action :active_nav
    before_action :set_user, only: [:edit, :update, :destroy]
    def active_nav
        @active = "user"
    end

    def index
      if current_user && (current_user.is_admin || current_user.id == 19)
        @users = User.all
      else
        redirect_to root_path
      end
    end

    def new
        @user = User.new
    end

    def edit
    end

    def create
      if params['password'] == params['password_confirmation']
        if params['password'].length > 5
          if params['phone_number'].start_with?('+569') && params['phone_number'].length == 12
            @user = User.create(user_params)
            puts params
            @user.name = params['first_name'] + ' ' + params['last_name']
            respond_to do |format|
              if @user.save
                format.html { redirect_to login_path}
              else
                format.html { render :new }
                format.json { render json: @user.errors, status: :unprocessable_entity }
              end
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
  
    # DELETE /pollas/1
    # DELETE /pollas/1.json
    def destroy
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
end