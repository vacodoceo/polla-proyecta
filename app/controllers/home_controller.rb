class HomeController < ApplicationController
  def show
    @active = "home"
  end
  def ranking
    @active = "ranking"
    @pollas = Polla.where(:valid_polla => 1).order(:score).reverse_order.limit(10)
  end

  def contact
  end

  def remember
    @pollas = Polla.where(:valid_polla => 0)
    puts "YELLLOW"
    @pollas.each do |polla|
      @user = User.find(polla.user_id)
      puts "HIELOOOOO"
      puts @user.name
      UserMailer.remember_pay(@user).deliver_now
    end
    redirect_to root_path, notice: "Se han enviado los recordatorios correctamente"
  end

  def send_feedback
    UserMailer.feedback(params, current_user.email).deliver_now
    redirect_to root_path, notice: "Se ha enviado el comentario correctamente. Muchas gracias por tu opinión!!"
  end
  def rules 
  end
  def faqs
  end
end
