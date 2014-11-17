class AppMailer < ActionMailer::Base
  def welcome_email(user)
    @user = user
    mail to: user.email, from: 'wagflix@gmail.com', subject: 'Welcome!'
  end

  def reset_password(user)
    @user = user
    mail to: user.email, from: 'wagflix@gmail.com', subject: 'Password reset'
  end
end
