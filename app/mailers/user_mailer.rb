class UserMailer < ApplicationMailer
    default :from => 'ti@trabajosproyecta.cl'
    def recover_password(user)
        @user = user
        @link = 'polla.trabajosproyecta.cl/new_password/' + @user.id.to_s
        mail(to: @user.email, subject: 'Recuperación de contraseña Polla Proyecta')
    end
end
