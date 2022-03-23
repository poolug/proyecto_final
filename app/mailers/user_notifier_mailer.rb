class UserNotifierMailer < ApplicationMailer
  default :from => 'pauluzcategui43@gmail.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Muchas gracias, por registrarte en Chanchito Sano' )
  end
end
