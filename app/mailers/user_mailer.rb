class UserMailer < ApplicationMailer
    default :from => 'ti@trabajosproyecta.cl'
    def recover_password(user)
        @user = user
        @link = 'localhost:3000/new_password/' + @user.id.to_s
        puts @link
        mail(to: @user.email, subject: 'Recuperación de contraseña Polla Proyecta')
    end
end
