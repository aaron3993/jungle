class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def welcome_email
    @user = params[:user]
    @url  = 'http://localhost.3000/login'
    mail(to: @user.email, subject: 'Welcome to the Jungle')
  end
end
