class AppMailer < ActionMailer::Base
  default from: "markscala@gmail.com"

  def welcome_email(user)
    @user = user
    mail to: user.email, subject: 'Welcome!'
  end

  def reset_password(user)
    @user = user
    mail to: user.email, subject: 'Password reset'
  end

  def invite_friend(name, email, message, inviter, token)
    @name, @message, @inviter, @token = name, message, inviter, token
    mail to: email, subject: "An invitation from #{inviter}!"
  end
end
