class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :get_prize
    helper_method :current_user

    def get_prize
      @pollas = Polla.where(:valid_polla => 1)
      @pozo = [52500, @pollas.length*350].max #corregir
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end
