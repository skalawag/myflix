class AppMailer < ActionMailer::Base
  def welcome_email(user)
    @user = user
    mail to: user.email, from: 'wagflix@gmail.com', subject: 'Welcome!'
  end

  def reset_password(user)
    @user = user
    mail to: user.email, from: 'wagflix@gmail.com', subject: 'Password reset'
  end

  def invite_friend(name, email, message, inviter, token)
    @name, @message, @inviter, @token = name, message, inviter, token
    mail to: email, from: 'wagflix@gmail.com', subject: "An invitation from #{inviter}!"
  end
end
