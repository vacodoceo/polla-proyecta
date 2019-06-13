class UserMailer < ApplicationMailer
    default :from => 'ti@trabajosproyecta.cl'
    def recover_password(user)
        @user = user
        options = 'abcdefghijklmnñopqrstuvwxyz1234567890?¿_:*^─·_:;<>!·$%$%&/()='
        
        hash_id = ''
        (0..12).each do |n|
            hash_id += options[rand(options.length - 1).floor]   
        end
        hash_id += @user.id.to_s + '¡'
        (0..15).each do |n|
            hash_id += options[rand(options.length - 1).floor]
        end

        #@link = 'localhost:3000/new_password/' + hash_id
        @link = 'polla.trabajosproyecta.cl/new_password/' + hash_id
        mail(to: @user.email, subject: 'Recuperación de contraseña Polla Proyecta')
    end

    def feedback(params, email)
        @comment = params['comment']
        @email = email
        mail(to: 'ti@trabajosproyecta.cl', subject: params['subject'])
    end
end
