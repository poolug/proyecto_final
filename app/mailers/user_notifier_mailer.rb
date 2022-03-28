class UserNotifierMailer < ApplicationMailer
  default :from => 'admin@chanchito-sano.com' # debes incluir un correo con dominio privado

  # send a signup email to the user, pass in the user object that contains the user's email address
  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Muchas gracias, por registrarte en Chanchito Sano' )
  end

  def send_signup_member_email(user_member, email_admin)
    @user = user_member
    @email = email_admin

    mail( :to => @user.email,
    :subject => 'Te han invitado a Chanchito Sano' )
  end
end
